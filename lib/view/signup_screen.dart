import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailTextController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.passwordTextController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.signUp();
              },
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
