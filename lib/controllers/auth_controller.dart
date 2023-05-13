import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/utils/nakama_listeners.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthResult { success, failure, userDoesNotExist, incomplete }

class AuthController extends GetxController {
  Logger logger = Get.find();
  NakamaBaseClient nakamaClient = Get.find();
  final UserController _userController = Get.find();
  Session? _session;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<AuthResult> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      session = await nakamaClient.authenticateEmail(
        email: email,
        password: password,
        create: false,
      );
      onSigninSuccess(session);
      return AuthResult.success;
    } catch (e) {
      logger.d(
        "Error signin with email and password",
      );
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatar,
      required String character,
      required String country}) async {
    try {
      session = await nakamaClient.authenticateEmail(
          email: email,
          password: password,
          create: true,
          username: username,
          vars: Map.of(
              {"country": country, "avatar": avatar, "character": character}));
      onSigninSuccess(session);
      return AuthResult.success;
    } catch (e) {
      logger.d(
        "Error signin with email and password",
      );
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithGoogle({bool successCallback = true}) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      session = await nakamaClient.authenticateGoogle(
        token: googleSignInAuthentication!.idToken!,
        create: false,
      );
      if (successCallback) onSigninSuccess(session);
      return AuthResult.success;
    } on GrpcError catch (e) {
      logger.d("Error signin with google", e);
      if (e.codeName == "NOT_FOUND") return AuthResult.userDoesNotExist;
      return AuthResult.failure;
    } catch (e) {
      logger.d("Error signin with google", e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signUpWithGoogle(
      {required String username,
      required String avatar,
      required String character,
      required String country}) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      session = await nakamaClient.authenticateGoogle(
          token: googleSignInAuthentication!.idToken!,
          create: true,
          username: username,
          vars: Map.of(
              {"country": country, "avatar": avatar, "character": character}));
      onSigninSuccess(session);
      return AuthResult.success;
    } catch (e) {
      logger.d("Error signup with google", e);
      return AuthResult.failure;
    }
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  Future<AuthResult> signInWithApple() async {
    return AuthResult.failure;
  }

  Future<AuthResult> signInWithFacebook() async {
    return AuthResult.failure;
  }

  Future<bool> checkIfUserExists(
      {required String email, required String password}) async {
    //todo later implement a backend route to check by email
    try {
      session = await nakamaClient.authenticateEmail(
        email: email,
        password: password,
        create: false,
      );
      onSigninSuccess(session);
      return true;
    } catch (e) {
      logger.d(
        "Fake no user exist Error signin with email and password",
      );
      return false;
    }
  }

  Future<void> onSigninSuccess(Session session) async {
    logger.i("on signin success token ${session.token}", session);
    var socket = NakamaWebsocketClient.init(
      host: '34.175.74.130',
      ssl: false,
      token: session.token,
    );
    logger.i("after signin  create socket", socket);

    setupListeners(socket);

    socket.onError != null
        ? ((error) {
            logger.e("Socket error", error);
            var errroStr = error.toString().toLowerCase();
            if (errroStr.contains("default has not yet been initialized") ||
                errroStr.contains("unauthenticated")) {
              socket = NakamaWebsocketClient.init(
                host: '34.175.74.130',
                ssl: false,
                token: session.token,
              );
            }
          })
        : null;

    _userController.fetchUserData(session);
    Get.find<LeaderboardsController>().fetchCurrentUserRecord();
  }

  Session get session => _session!;
  set session(Session value) => _session = value;

  void refreshSession() {}
}
