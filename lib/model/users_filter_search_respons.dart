import 'dart:convert';

import 'package:medzo/utils/utils.dart';

class UserFilterSearchModel {
  final String id;
  final String name;
  final String? profilePicture;
  final double? latitude;
  final double? longitude;
  final int totalPetCounts;
  final double distance;
  UserFilterSearchModel({
    required this.id,
    this.name = "",
    this.profilePicture,
    this.latitude,
    this.longitude,
    required this.totalPetCounts,
    required this.distance,
  });

  UserFilterSearchModel copyWith({
    String? id,
    String? name,
    String? profilePicture,
    double? latitude,
    double? longitude,
    int? totalPetCounts,
    double? distance,
  }) {
    return UserFilterSearchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      totalPetCounts: totalPetCounts ?? this.totalPetCounts,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
      'totalPetCounts': totalPetCounts,
      'distance': distance,
    };
  }

  factory UserFilterSearchModel.fromMap(Map<String, dynamic> map) {
    return UserFilterSearchModel(
      id: map['id'] ?? "",
      name: map['name'] ?? '',
      profilePicture: map['profilePicture'],
      latitude: Utils.getLong(map['latitude']?.toDouble()),
      longitude: Utils.getLong(map['longitude']?.toDouble()),
      totalPetCounts: map['totalPetCounts']?.toInt() ?? 0,
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFilterSearchModel.fromJson(String source) =>
      UserFilterSearchModel.fromMap(json.decode(source));
}
