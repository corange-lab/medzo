import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/controller/global_config_controller.dart';
import 'package:medzo/controller/network_handling_service.dart';
import 'package:medzo/controller/user_controller.dart';
import 'package:medzo/firebase_options.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppStorage().initStorage();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: AppColors.lightGrey,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          initialRoute: '/',
          useInheritedMediaQuery: true,
          title: 'Medzo',
          theme: ThemeColor.mThemeData(context),
          darkTheme: ThemeColor.mThemeData(context, isDark: true),
          initialBinding: GlobalBindings(),
          defaultTransition: Transition.cupertino,
          opaqueRoute: Get.isOpaqueRouteDefault,
          popGesture: Get.isPopGestureEnable,
          transitionDuration: const Duration(milliseconds: 500),
          defaultGlobalState: true,
          themeMode: ThemeMode.light,
          home: SplashScreen()),
    );
  }
}

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.put(NetworkHandlingService(), permanent: true);
    Get.lazyPut(() => GlobalConfigController(), fenix: true);
  }
}
