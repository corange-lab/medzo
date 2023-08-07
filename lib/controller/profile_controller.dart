import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/model/user_model.dart';

class ProfileController extends GetxController {
  final String? uId;

  ProfileController(this.uId);

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  // fetch the UserModel value from dataSnapShot
  Rx<UserModel> get user => _user;
  Rx<UserModel> _user = UserModel().obs;

  Stream<QuerySnapshot>? dataSnapShot;

  @override
  void onInit() {
    dataSnapShot = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uId ?? FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    super.onInit();
    dataSnapShot!.listen((event) {
      _user.value = UserModel.fromDocumentSnapshot(event.docs.first);
      nameController.text = _user.value.name ?? '';
      professionController.text = _user.value.profession ?? '';
      update();
    });
  }
}
