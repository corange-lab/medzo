class UserRelationship {
  final String userId;
  final DateTime timestamp;

  UserRelationship({
    required this.userId,
    required this.timestamp,
  });

  factory UserRelationship.fromMap(Map<String, dynamic> map) {
    return UserRelationship(
      userId: map['userId'],
      timestamp: map['timestamp'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'timestamp': timestamp,
    };
  }

  UserRelationship copyWith({
    String? userId,
    DateTime? timestamp,
  }) {
    return UserRelationship(
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() =>
      'UserRelationship(userId: $userId, timestamp: $timestamp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRelationship && other.userId == userId;
  }
}
