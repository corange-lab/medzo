import 'package:get/get.dart';
import 'package:medzo/view/home_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.to(() => const HomeScreen());
    });
  }
}
