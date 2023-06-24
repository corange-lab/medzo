import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: ThemeColor.lightGrey,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: '/',
        useInheritedMediaQuery: true,
        title: 'Medzo',
        theme: ThemeColor.mThemeData(context),
        darkTheme: ThemeColor.mThemeData(context, isDark: true),
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: const Duration(milliseconds: 500),
        defaultGlobalState: true,
        themeMode: ThemeMode.light,
        home: const SplashScreen());
  }
}
