import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgotcontroller extends GetxController{
  RxBool pageStatus = false.obs;
  RxInt btnClick = 0.obs;

  TextEditingController emailTextController = TextEditingController();

}