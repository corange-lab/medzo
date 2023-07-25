import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/assets.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();

  static UserRepository get instance => _singleton;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  /*
  * private constructor to make a singleton object
  * */
  UserRepository._internal();

  static UserRepository getInstance() {
    return _singleton;
  }

  Future<UserModel> createNewUser(UserModel user) async {
    final newDocRef = _usersCollection.doc(user.id);
    UserModel newUser = user.copyWith(id: newDocRef.id);
    await newDocRef.set(newUser.toMap());
    return newUser;
  }

  Future<void> updateUser(UserModel user) async {
    await _usersCollection.doc(user.id).update(user.toMap());
  }

  Future<UserModel?> getUserById(String? id) async {
    if (id == null) {
      return null;
    }
    DocumentReference documentReference = _usersCollection.doc(id);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.data() == null) {
      return null;
    }
    return UserModel.fromMap(documentSnapshot.data()! as Map<String, dynamic>);
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final querySnapshot = await _usersCollection
        .where(UserModelField.email, isEqualTo: email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return UserModel.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<UserModel>?> getUsersByIds(List<String?> userIds) async {
    final querySnapshot =
        await _usersCollection.where(UserModelField.id, whereIn: userIds).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((e) => UserModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    }
    return null;
  }
}
