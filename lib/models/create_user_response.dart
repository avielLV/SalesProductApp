// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'dart:convert';

class CreateUserResponse {
  CreateUserResponse({
    this.kind,
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
  });

  String? kind;
  String idToken;
  String email;
  String refreshToken;
  String expiresIn;
  String localId;

  factory CreateUserResponse.fromRawJson(String str) =>
      CreateUserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      CreateUserResponse(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "idToken": idToken,
        "email": email,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "localId": localId,
      };
}
