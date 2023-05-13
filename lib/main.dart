import 'package:firebase_core/firebase_core.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/controllers/main_menu_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';
import 'package:nouns_flutter/controllers/store_controller.dart';
import 'package:nouns_flutter/firebase_options.dart';
import 'package:nouns_flutter/pages/join_mp_game.dart';
import 'package:nouns_flutter/pages/mp_gameover.dart';
import 'package:nouns_flutter/pages/mp_gamesetup.dart';
import 'package:nouns_flutter/pages/loading_screen.dart';
import 'package:nouns_flutter/pages/mp_launch.dart';
import 'package:nouns_flutter/pages/mp_round_results.dart';
import 'package:nouns_flutter/pages/sp_gameover.dart';
import 'package:nouns_flutter/pages/sp_gameplay.dart';
import 'package:nouns_flutter/pages/sp_tutorial.dart';
import 'package:nouns_flutter/pages/store.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/pages/user_init.dart';
import 'package:nouns_flutter/pages/main_menu.dart';
import 'package:nouns_flutter/pages/splash.dart';
import 'package:nouns_flutter/pages/mp_gameplay.dart';
import 'package:nouns_flutter/pages/select_alphabet.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() async {
        Get.put(await SharedPreferences.getInstance(), permanent: true);
        Get.put(Logger(output: ConsoleAndFileOutput()), permanent: true);
        Get.put(AnimationsController(), permanent: true);
        Get.put(SingleplayerController(), permanent: true);
        Get.put(InitializeUserController(), permanent: true);
        Get.put(
            getNakamaClient(
              host: '34.175.74.130',
              ssl: false,
              serverKey: 'defaultkey',
              // grpcPort: 7349, // optional
              // httpPort: 7350, // optional
            ),
            permanent: true);
        Get.put(UserController(), permanent: true);
        Get.put(MainMenuController(), permanent: true);
        Get.put(AuthController(), permanent: true);
        Get.put(LeaderboardsController(), permanent: true);
        Get.put(GameController(), permanent: true);
        Get.put(MpSetupController(), permanent: true);
        Get.put(MpController(), permanent: true);
        Get.put(StoreController(), permanent: true);

        //cacheSounds();
      }),
      title: 'Flutter Demo',
      //initialRoute: '/',
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/loading', page: () => const LoadingScreen()),
        GetPage(name: '/init', page: () => const InitializeUser()),
        GetPage(name: '/mainMenu', page: () => const MainMenu()),
        GetPage(name: '/spTutorial', page: () => const SpTutorial()),
        GetPage(name: '/singleplayer', page: () => const Singleplayer()),
        GetPage(name: '/mpLaunch', page: () => const MultiplayerLaunch()),
        GetPage(name: '/mpSetup', page: () => const MpGameSetup()),
        GetPage(name: '/joinGame', page: () => const JoinGameMp()),
        GetPage(name: '/spGameover', page: () => const SpGameOver()),
        GetPage(name: '/mpGameover', page: () => const MpGameOver()),
        GetPage(name: '/multiplayer', page: () => const MpGameplay()),
        GetPage(
            name: '/mpSelectAlphabet', page: () => const MpSelectAlphabet()),
        GetPage(name: '/roundResults', page: () => const MpRoundResults()),
        GetPage(name: '/store', page: () => const Store()),
      ],

      theme: ThemeData(
        primaryColor: primaryColor,
        highlightColor: whiteColor,
        buttonTheme:
            Theme.of(context).buttonTheme.copyWith(buttonColor: primaryColor),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        fontFamily: 'VanillaExtract',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 12.0, fontFamily: 'VanillaExtract'),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: primaryColor.withOpacity(0.8),
            contentTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white)), //Refer This
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
