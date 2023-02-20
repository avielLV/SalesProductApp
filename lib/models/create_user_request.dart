// To parse this JSON data, do
//
//     final createUserRequest = createUserRequestFromJson(jsonString);

import 'dart:convert';

class CreateUserRequest {
  CreateUserRequest({
    required this.email,
    required this.password,
    required this.returnSecureToken,
  });

  String email;
  String password;
  bool returnSecureToken;

  factory CreateUserRequest.fromRawJson(String str) =>
      CreateUserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      CreateUserRequest(
        email: json["email"],
        password: json["password"],
        returnSecureToken: json["returnSecureToken"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "returnSecureToken": returnSecureToken,
      };
}
