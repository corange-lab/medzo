import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/model/post_model.dart';

class PostController extends GetxController {
  PostModel newPost = PostModel();

  RxList<bool> isSaveMedicine = List.filled(5, false).obs;
  RxList<bool> isSaveExpert = List.filled(4, false).obs;
  var pageController = PageController().obs;
  RxInt pageIndex = 0.obs;
}
