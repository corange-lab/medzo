class ReportData {
  final String userId;
  final String reason;

  ReportData({
    required this.userId,
    required this.reason,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'reason': reason,
    };
  }

  factory ReportData.fromMap(Map<String, dynamic> map) {
    return ReportData(
      userId: map['userId'],
      reason: map['reason'],
    );
  }
}
