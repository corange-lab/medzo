import 'dart:convert';

import 'package:medzo/model/user_model.dart';

class AllUsersResponse {
  final int? pageNumber;
  final int? pageSize;
  final String? sortBy;
  final String? sortOrder;
  final String? keyword;
  final int? totalPages;
  final List<UserModel>? users;

  AllUsersResponse(
      {this.users,
      this.pageNumber,
      this.pageSize,
      this.sortBy,
      this.sortOrder,
      this.keyword,
      this.totalPages});

  Map<String, dynamic> toMap() {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'keyword': keyword,
      'totalPages': totalPages,
      'users': users,
    };
  }

  factory AllUsersResponse.fromJson(Map<String, dynamic> map) {
    return AllUsersResponse(
      pageNumber: map['pageNumber'],
      pageSize: map['pageSize'],
      sortBy: map['sortBy'],
      sortOrder: map['sortOrder'],
      keyword: map['keyword'],
      totalPages: map['totalPages'],
      users: (map['users'] as List)
          .map((dynamic e) => UserModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());
}
