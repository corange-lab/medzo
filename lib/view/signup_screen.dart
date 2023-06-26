import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: const [
            Text('SignUp Screen'),
          ],
        ));
  }
}
