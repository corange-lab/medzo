import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  final dataSnapShot = FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
