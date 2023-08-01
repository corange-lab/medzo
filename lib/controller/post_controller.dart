import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/model/post_model.dart';

class PostController extends GetxController {
  PostData newPost = PostData();

  RxList<File> selectedMultiImages = <File>[].obs;

  TextEditingController description = TextEditingController();
  RxList<bool> isSaveMedicine = List.filled(5, false).obs;
  RxList<bool> isSaveExpert = List.filled(4, false).obs;
  var pageController = PageController().obs;
  RxInt pageIndex = 0.obs;

  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference postRef =
      FirebaseFirestore.instance.collection('posts');

  // implement functionality to upload image in firebase storage inside the post directory
  Future<String?> uploadImage(PostImageData imageData) async {
    UploadTask uploadTask = uploadFile(
        File(imageData.path!), imageData.path!.split("/").last.toString());
    try {
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("posts/${loggedInUserId}/${fileName}");
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}
