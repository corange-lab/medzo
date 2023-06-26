import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/otp_controller.dart';

class OTPScreen extends GetView<OTPController> {
  final String email, verificationId;
  const OTPScreen({Key? key, required this.email, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OTPController(/*email: email, verificationId: verificationId*/),
      builder: (controller) {
        return Scaffold(
            body: Column(
          children: const [
            Text('OTP Screen'),
          ],
        ));
      },
    );
  }
}
