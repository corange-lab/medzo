import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          children: const [
            Text('Home Screen'),
          ],
        ));
      },
    );
  }
}
