import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/apiConfig.dart';
import '../models/UserProfile.dart';
import '../models/login_response.dart';

class AuthRepository {
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Api.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
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

    throw Exception("Token invalid");
  }
}
