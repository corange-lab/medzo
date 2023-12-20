import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medzo/model/age_group.dart';
import 'package:medzo/model/allergies.dart';
import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/health_condition.dart';
import 'package:medzo/utils/firebase_utils.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? fcmToken;
  final String? gender;
  final String? profilePicture;
  final String? profession;
  final bool? enablePushNotification;
  final bool? isBlocked;
  final dynamic healthCondition; //HealthCondition?
  final dynamic currentMedication; //CurrentMedication?
  final dynamic allergies; //Allergies?
  final dynamic ageGroup; //AgeGroup?
  double? similarityScore;
  final bool? isEulaAccepted;
  final DateTime? eulaAcceptedDate;

  UserModel._({
    this.id,
    this.name,
    this.email,
    this.fcmToken,
    this.gender,
    this.profilePicture,
    this.profession,
    this.enablePushNotification,
    this.isBlocked,
    this.healthCondition,
    this.currentMedication,
    this.allergies,
    this.ageGroup,
    this.similarityScore,
    this.isEulaAccepted,
    this.eulaAcceptedDate,
  });

  UserModel.newUser({
    this.id,
    this.name,
    this.email,
    this.fcmToken,
    this.gender,
    this.profilePicture,
    this.profession,
    this.enablePushNotification,
    this.isBlocked,
    this.healthCondition,
    this.currentMedication,
    this.allergies,
    this.ageGroup,
    this.similarityScore,
    this.isEulaAccepted,
    this.eulaAcceptedDate,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? country,
    String? fcmToken,
    String? gender,
    String? profilePicture,
    String? profession,
    bool? enablePushNotification,
    bool? isBlocked,
    dynamic healthCondition, // HealthCondition?
    dynamic currentMedication, // CurrentMedication?
    dynamic ageGroup, // AgeGroup?
    dynamic allergies, // Allergies?
    double? similarityScore,
    bool? isEulaAccepted,
    DateTime? eulaAcceptedDate,
  }) {
    return UserModel._(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      gender: gender ?? this.gender,
      profilePicture: profilePicture ?? this.profilePicture,
      profession: profession ?? this.profession,
      enablePushNotification:
          enablePushNotification ?? this.enablePushNotification,
      isBlocked: isBlocked ?? this.isBlocked,
      healthCondition: healthCondition ?? this.healthCondition,
      currentMedication: currentMedication ?? this.currentMedication,
      ageGroup: ageGroup ?? this.ageGroup,
      allergies: allergies ?? this.allergies,
      similarityScore: similarityScore ?? this.similarityScore,
      isEulaAccepted: isEulaAccepted ?? this.isEulaAccepted,
      eulaAcceptedDate: eulaAcceptedDate ?? this.eulaAcceptedDate,
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
      'profession': profession,
      'enablePushNotification': enablePushNotification,
      'isBlocked': isBlocked,
      'health_condition': (healthCondition is bool)
          ? healthCondition
          : healthCondition?.toMap(),
      'current_medication': (currentMedication is bool)
          ? currentMedication
          : currentMedication?.toMap(),
      'age_group': (ageGroup is bool) ? ageGroup : ageGroup?.toMap(),
      'allergies': (allergies is bool) ? allergies : allergies?.toMap(),
      'isEulaAccepted': isEulaAccepted,
      'eulaAcceptedDate': eulaAcceptedDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel._(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      fcmToken: map['fcmToken'],
      gender: map['gender'],
      profilePicture: map['profile_picture'],
      profession: map['profession'],
      enablePushNotification: map['enablePushNotification'],
      isBlocked: map['isBlocked'],
      healthCondition: map['health_condition'] == null
          ? null
          : (map['health_condition'] is bool)
              ? map['health_condition']
              : HealthCondition.fromMap(map['health_condition']),
      currentMedication: map['current_medication'] == null
          ? null
          : (map['current_medication'] is bool)
              ? map['current_medication']
              : CurrentMedication.fromMap(map['current_medication']),
      ageGroup: map['age_group'] == null
          ? null
          : (map['age_group'] is bool)
              ? map['age_group']
              : AgeGroup.fromMap(map['age_group']),
      allergies: map['allergies'] == null
          ? null
          : (map['allergies'] is bool)
              ? map['allergies']
              : Allergies.fromMap(map['allergies']),
      isEulaAccepted: map['isEulaAccepted'],
      eulaAcceptedDate: map['eulaAcceptedDate'] != null
          ? FirebaseUtils.timestampToDateTime(map['eulaAcceptedDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return UserModel._(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      fcmToken: map['fcmToken'],
      gender: map['gender'],
      profilePicture: map['profile_picture'],
      profession: map['profession'],
      enablePushNotification: map['enablePushNotification'],
      isBlocked: map['isBlocked'],
      healthCondition: map['health_condition'] == null
          ? null
          : (map['health_condition'] is bool)
              ? map['health_condition']
              : HealthCondition.fromMap(map['health_condition']),
      currentMedication: map['current_medication'] == null
          ? null
          : (map['current_medication'] is bool)
              ? map['current_medication']
              : CurrentMedication.fromMap(map['current_medication']),
      ageGroup: map['age_group'] == null
          ? null
          : (map['age_group'] is bool)
              ? map['age_group']
              : AgeGroup.fromMap(map['age_group']),
      allergies: map['allergies'] == null
          ? null
          : (map['allergies'] is bool)
              ? map['allergies']
              : Allergies.fromMap(map['allergies']),
      isEulaAccepted: map['isEulaAccepted'],
      eulaAcceptedDate: map['eulaAcceptedDate'] != null
          ? FirebaseUtils.timestampToDateTime(map['eulaAcceptedDate'])
          : null,
    );
  }
}

class UserModelField {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String role = 'role';
  static const String profilePicture = 'profilePicture';
  static const String profession = 'profession';
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
