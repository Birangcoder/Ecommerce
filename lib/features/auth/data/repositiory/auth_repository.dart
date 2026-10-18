import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/apiConfig.dart';
import '../model/UserProfile.dart';
import '../model/login_response.dart';

class AuthRepository {
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Api.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "expiresInMins": 30,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    }

    if (response.statusCode == 401) {
      if (kDebugMode) {
        debugPrint('Token expired or invalid — forcing logout');
      }
    }

    throw Exception("Login Failed");
  }

  Future<UserProfile> getCurrentUser(String accessToken) async {
    final response = await http.get(
      Uri.parse(Api.currentUser),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }

    if (response.statusCode == 401) {
      if (kDebugMode) {
        debugPrint('Token expired or invalid — forcing logout');
      }
    }

    throw Exception("Token invalid");
  }
}
