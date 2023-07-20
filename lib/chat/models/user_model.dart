part of 'models.dart';

class UserChatModel {
  final String? id;
  final String? name;
  final String? profilePicture;
  final String? email;
  UserChatModel({
    this.id,
    this.name,
    this.profilePicture,
    this.email,
  });

  UserChatModel copyWith({
    String? id,
    String? name,
    String? profilePicture,
    String? email,
  }) {
    return UserChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
    };
  }

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      id: map['id'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChatModel.fromJson(String source) =>
      UserChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, name: $name, profilePicture: $profilePicture, email: $email)';
  }
}
