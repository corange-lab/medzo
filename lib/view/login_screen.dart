import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (ctrl) {
          return SafeArea(
            child: Scaffold(
                body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: ctrl.emailTextController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: ctrl.passwordTextController,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await ctrl.signInWithEmailAndPassword();
                    },
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      ctrl.navigateToSignUp();
                    },
                    child: Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.signInWithApple();
                        },
                        child: Text(
                          'Sign In with Apple',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await controller.signInWithGoogle();
                        },
                        child: Text(
                          'Sign In with Google',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
