import 'dart:developer';

import 'package:get/get.dart';
import 'package:medzo/utils/app_storage.dart';

class GlobalConfigController extends GetxController {
  AppStorage appStorage = AppStorage();

  @override
  void onInit() {
    log('GlobalConfigController onInit');
    super.onInit();
  }

  GlobalConfigController();
}
