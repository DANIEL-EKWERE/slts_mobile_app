// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
    final String? email;
    final String? token;

    TokenModel({
        this.email,
        this.token,
    });

    factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        email: json["email"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
    };
}
