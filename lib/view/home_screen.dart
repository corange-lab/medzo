import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (ctrl) {
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Home Screen')),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await controller.signOut();
              },
              child: Text(
                'Sign Out',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ));
      },
    );
  }
}
