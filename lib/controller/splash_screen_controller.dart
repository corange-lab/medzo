import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:medzo/view/login_screen.dart';

class SplashScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (_auth.currentUser != null) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }
}
