import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proudcto_app/models/models.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAsYqwX2fYn9E94HX-uizTcK7rBUXInuck';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(CreateUserRequest request) async {
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: jsonEncode(request));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(CreateUserRequest request) async {
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final resp = await http.post(url, body: jsonEncode(request));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);

      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
