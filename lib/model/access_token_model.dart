import 'dart:convert';

AccessTokenModel accessTokenModelFromJson(String str) => AccessTokenModel.fromJson(json.decode(str));

String accessTokenModelToJson(AccessTokenModel data) => json.encode(data.toJson());

class AccessTokenModel {
    String token;
    bool used;
    String? username;
    String? userDomain;
    String? createdAt;
    String? updatedAt;
    String? updatedBy;
    String? expiryDate;

    AccessTokenModel({
        required this.token,
        required this.used,
        this.username,
        this.userDomain,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.expiryDate,
    });

    factory AccessTokenModel.fromJson(Map<String, dynamic> json) => AccessTokenModel(
        token: json['token'],
        used: json['used'],
        username: json['username'],
        userDomain: json['userDomain'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        updatedBy: json['updatedBy'],
        expiryDate: json['expiryDate'],
    );

    Map<String, dynamic> toJson() => {
        'token': token,
        'used': used,
        'username': username,
        'userDomain': userDomain,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'updatedBy': updatedBy,
        'expiryDate': expiryDate,
    };
}
