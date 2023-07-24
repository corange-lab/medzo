import 'dart:convert';

import 'package:medzo/model/age_group.dart';
import 'package:medzo/model/allergies.dart';
import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/health_condition.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? fcmToken;
  final String? gender;
  final String? age;
  final String? profilePicture;
  final bool? enablePushNotification;
  final HealthCondition? healthCondition;
  final CurrentMedication? currentMedication;
  final Allergies? allergies;
  final AgeGroup? ageGroup;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.fcmToken,
    this.gender,
    this.age,
    this.profilePicture,
    this.enablePushNotification,
    this.healthCondition,
    this.currentMedication,
    this.allergies,
    this.ageGroup
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? country,
    String? fcmToken,
    String? gender,
    String? age,
    String? profilePicture,
    bool? enablePushNotification,
    HealthCondition? healthCondition,
    CurrentMedication? currentMedication,
    AgeGroup? ageGroup,
    Allergies? allergies,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      profilePicture: profilePicture ?? this.profilePicture,
      enablePushNotification:
          enablePushNotification ?? this.enablePushNotification,
      healthCondition: healthCondition ?? this.healthCondition,
      currentMedication: currentMedication ?? this.currentMedication,
      ageGroup: ageGroup ?? this.ageGroup,
      allergies: allergies ?? this.allergies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'fcmToken': fcmToken,
      'gender': gender,
      'profile_picture': profilePicture,
      'age': age,
      'enablePushNotification': enablePushNotification,
      'health_condition': healthCondition?.toMap(),
      'current_medication': currentMedication?.toMap(),
      'age_group': ageGroup?.toMap(),
      'allergies': allergies?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      fcmToken: map['fcmToken'],
      gender: map['gender'],
      profilePicture: map['profile_picture'],
      age: map['age'],
      enablePushNotification: map['enablePushNotification'],
      healthCondition: map['health_condition'] == null ? null : HealthCondition.fromMap(map['health_condition']),
      currentMedication: map['current_medication'] == null ? null : CurrentMedication.fromMap(map['current_medication']),
      ageGroup: map['age_group'] == null ? null : AgeGroup.fromMap(map['age_group']),
      allergies: map['allergies'] == null ? null : Allergies.fromMap(map['allergies']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}


class UserModelField {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String role = 'role';
  static const String profilePicture = 'profilePicture';
  static const String bio = 'bio';
  static const String birthdate = 'birthdate';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String fcmToken = 'fcmToken';
  static const String status = 'status';
  static const String location = 'address';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
}