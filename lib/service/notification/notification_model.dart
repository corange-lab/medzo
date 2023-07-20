import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModelField {
  static const String time = 'time';
}

class NotificationModel {
  final String id;
  final int? eventId;
  final String content;
  final String? image;
  final String time;
  final String path;

  NotificationModel({
    required this.id,
    this.eventId,
    required this.content,
    this.image,
    required this.path,
    required this.time,
  });

  NotificationModel copyWith({
    String? id,
    int? eventId,
    String? content,
    String? image,
    String? time,
    String? path,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      content: content ?? this.content,
      image: image ?? this.image,
      time: time ?? this.time,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'eventId': eventId,
      'content': content,
      'image': image,
      'time': time,
      'path': path,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? 0,
      eventId: map['eventId'],
      content: map['content'],
      image: map['image'],
      time: ((map['time'] as Timestamp).toDate().toString()),
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
