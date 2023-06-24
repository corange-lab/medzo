import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/splash_screen_controller.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          children: const [
            Text('Medzo'),
          ],
        ));
      },
    );
  }
}
