import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/connection.dart';
import 'package:nouns_flutter/widgets/common/loadering_bar.dart';
import 'package:nouns_flutter/widgets/init_user/network_error_dialog.dart';

import '../firebase_options.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  final Logger _logger = Get.find();
  final AuthController _authController = Get.find();
  final InitializeUserController _initializeUserController = Get.find();
  var _authResult = AuthResult.incomplete;

  late final AnimationController _animationController;
  late final Animation<AlignmentGeometry> _animation;

  var switchImages = false;
  var showSlider = false;
  var catgeoriesLoaded = false;
  var loadingBarFinished = false;
  var networkError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          var pageWidth = constraints.maxWidth;
          var pageHeight = constraints.maxHeight;

          return Container(
              color: Colors.transparent,
              width: pageWidth,
              height: pageHeight,
              child: Stack(alignment: Alignment.topCenter, children: [
                Positioned.fill(
                  child: Container(
                    width: pageWidth,
                    height: pageHeight,
                    child: AnimatedCrossFade(
                        firstChild: Image.asset(
                          'assets/images/SplashScreens/splash_1.png',
                          fit: BoxFit.cover,
                          width: pageWidth,
                          height: pageHeight,
                        ),
                        secondChild: Image.asset(
                          'assets/images/SplashScreens/splash_2.png',
                          fit: BoxFit.cover,
                          width: pageWidth,
                          height: pageHeight,
                        ),
                        crossFadeState: switchImages
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(seconds: 2)),
                  ),
                ),
                AlignTransition(
                    alignment: _animation,
                    child: AnimatedCrossFade(
                        alignment: Alignment.bottomCenter,
                        firstCurve: Curves.easeOut,
                        secondCurve: Curves.easeIn,
                        firstChild: Container(
                          margin: const EdgeInsets.only(bottom: 40, top: 75),
                          child: Image.asset(
                            'assets/images/Common/nouns_title.png',
                            width: pageWidth * 0.6,
                          ),
                        ),
                        secondChild: Container(
                            margin: const EdgeInsets.only(bottom: 40, top: 75),
                            child: Image.asset(
                              'assets/images/Common/nouns_title.png',
                              width: pageWidth * 0.6,
                            )),
                        crossFadeState: switchImages
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(seconds: 2))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 20, top: 10),
                    width: pageWidth * 0.8,
                    child: AnimatedCrossFade(
                      alignment: Alignment.bottomCenter,
                      firstChild: Text(
                        "Game and Software \u00a9 Dash Studios. Dash Studios and its Logo are a trademark of Dash Studios.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: whiteColor,
                              fontSize: 10,
                            ),
                      ),
                      secondChild: LoadingBar(
                        milliseconds: 3000,
                        onFinished: loadingBarFinishedCallback,
                      ),
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: showSlider
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                  ),
                ),
                Positioned.fill(
                    child: AnimatedScale(
                        duration: const Duration(milliseconds: 500),
                        scale: networkError ? 1 : 0,
                        child: NetworkErrorDialog(retryConnection: () {
                          setState(() {
                            networkError = false;
                          });
                          startupSequence();
                        }))),
              ]));
        }));
  }

  @override
  void initState() {
    super.initState();
    startupSequence();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const ElasticInOutCurve(0.85),
      ),
    );

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _animationController.forward();
      });
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        switchImages = true;
        showSlider = true;
      });
    });
  }

  void startupSequence() async {
    if (!(await connectionOk())) {
      setState(() {
        networkError = true;
      });

      return;
    }

    Categories.load().then((_) {
      catgeoriesLoaded = true;
      _logger.i('App Startup Complete. Data fetched Succcessfully');
    });

    attemptSignin();

    Future.doWhile(() async {
      if (loadingBarFinished &&
          catgeoriesLoaded &&
          _authResult != AuthResult.incomplete) {
        onReadyToGoToNextScreen();
        return false;
      }
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  void loadingBarFinishedCallback() {
    loadingBarFinished = true;
  }

  Future<void> attemptSignin() async {
    // var userExists = await _authController.checkIfUserExists(
    //     email: "ndirangu.mepawa@gmail.com", password: "George!11116");
    // _initializeUserController.email = "ndirangu.mepawa@gmail.com";
    // _initializeUserController.password = "George!11116";

    // if (userExists) {
    //   //also signedin
    //   _authResult = AuthResult.success;
    // } else {
    //   _authResult = AuthResult.userDoesNotExist;
    // }
    _authResult = await _authController.signInWithGoogle();
  }

  void onReadyToGoToNextScreen() {
    switch (_authResult) {
      case AuthResult.success:
        logger.i("Signin");
        //Get.toNamed('/mainMenu');
        Navigator.of(context).pushReplacementNamed('/mainMenu');
        break;
      case AuthResult.userDoesNotExist:
        logger.i("User does not exist, redirecting to signup");
        //Get.toNamed('/init');
        Navigator.of(context).pushReplacementNamed('/init');
        break;
      case AuthResult.failure:
      default:
        logger.e("Failed to Login, try again");
    }
  }
}
