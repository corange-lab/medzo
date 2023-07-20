import 'dart:convert';

class InvitePeople {
  String? id = "";
  String email = "";
  String? name = "";

  InvitePeople({this.id, required this.email, this.name});

  InvitePeople copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return InvitePeople(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  factory InvitePeople.fromMap(Map<String, dynamic> map) {
    return InvitePeople(
      id: map['id'],
      email: map['email'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InvitePeople.fromJson(String source) =>
      InvitePeople.fromMap(json.decode(source));
}
