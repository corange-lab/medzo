import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';

class profile_screen extends StatelessWidget {
  const profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await controller.signOut();
            },
            child: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ));
      },
    );
  }
}
