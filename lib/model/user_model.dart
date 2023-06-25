import 'dart:convert';

import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/health_condition.dart';

class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? fcmToken;
  final String? gender;
  final String? age;
  final bool? enablePushNotification;
  final HealthCondition? healthCondition;
  final CurrentMedication? currentMedication;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.fcmToken,
    this.gender,
    this.age,
    this.enablePushNotification,
    this.healthCondition,
    this.currentMedication,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? country,
    String? fcmToken,
    String? gender,
    String? age,
    bool? enablePushNotification,
    HealthCondition? healthCondition,
    CurrentMedication? currentMedication,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      enablePushNotification:
          enablePushNotification ?? this.enablePushNotification,
      healthCondition: healthCondition ?? this.healthCondition,
      currentMedication: currentMedication ?? this.currentMedication,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'fcmToken': fcmToken,
      'gender': gender,
      'age': age,
      'enablePushNotification': enablePushNotification,
      'health_condition': healthCondition?.toMap(),
      'current_medication': currentMedication?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      fcmToken: map['fcmToken'],
      gender: map['gender'],
      age: map['age'],
      enablePushNotification: map['enablePushNotification'],
      healthCondition: map['health_condition'] == null ? null : HealthCondition.fromMap(map['health_condition']),
      currentMedication: map['current_medication'] == null ? null : CurrentMedication.fromMap(map['current_medication']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
