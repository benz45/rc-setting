import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rc_setting/model/access_token_model.dart';
import 'package:rc_setting/model/base_request_model.dart';
import 'package:http/http.dart' as http;

class GoogleSheetService {
  Future<AccessTokenModel>? fetchAccessTokenByToken(String token) async {
    try {
      final String url = '${dotenv.env['GOOGLE_SHEET']}?token=$token';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final res = baseRequestModelFromJson(response.body);
        if (res.status == 200) {
          return AccessTokenModel.fromJson(res.data);
        } else {
          throw Exception('Failed to load access token');
        }
      } else {
        throw Exception('Failed to load access token');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<AccessTokenModel>? updateAccessToken(
      String token, String userDomain) async {
    try {
      final String url = '${dotenv.env['GOOGLE_SHEET']}?update';

      var response = await Dio().post(
        url,
        data: json.encode(
          {'token': token, 'isUse': true, 'userDomain': userDomain},
        ),
        options: Options(
            contentType: 'application/json',
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              'Accept': 'application/json',
              'X-Requested-With': 'XMLHttpRequest'
            },
            responseType: ResponseType.json),
      );
      if (response.statusCode == 302) {
        final redirectedUrl = response.headers['location'];
        if (redirectedUrl != null) {
          final newResponse =
              await http.get(Uri.parse(redirectedUrl[0]));
          if (newResponse.statusCode == 200) {
            var jsonData = json.decode(newResponse.body);
            if (jsonData['status'] == 400) {
              throw Exception(jsonData['data']);
            }
            var base = baseRequestModelFromJson(newResponse.body);
            var d= AccessTokenModel.fromJson(base.data);
            return d;
          } else {
            throw Exception('Error: ${newResponse.statusCode}');
          }
        } else {
          throw Exception('No redirection URL found');
        }
      } else if (response.statusCode == 200) {
        final res = baseRequestModelFromJson(response as String);
        if (res.status == 200) {
          return AccessTokenModel.fromJson(res.data);
        } else {
          throw Exception('Failed to update access token');
        }
      } else {
        throw Exception('Failed to update access token${response.statusCode}');
      }
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<AccessTokenModel>? deleteAccessToken(
      String token, String userDomain) async {
    try {
      final String url = '${dotenv.env['GOOGLE_SHEET']}?update';

      var response = await Dio().post(
        url,
        data: json.encode(
          {'token': token, 'isUse': false, 'userDomain': userDomain},
        ),
        options: Options(
            contentType: 'application/json',
            followRedirects: false,
            validateStatus: (status) => true,
            headers: {
              'Accept': 'application/json',
              'X-Requested-With': 'XMLHttpRequest'
            },
            responseType: ResponseType.json),
      );
      if (response.statusCode == 302) {
        final redirectedUrl = response.headers['location'];
        if (redirectedUrl != null) {
          final newResponse =
              await http.get(Uri.parse(redirectedUrl[0]));
          if (newResponse.statusCode == 200) {
            var base = baseRequestModelFromJson(newResponse.body);
            var d= AccessTokenModel.fromJson(base.data);
            return d;
          } else {
            throw Exception('Error: ${newResponse.statusCode}');
          }
        } else {
          throw Exception('No redirection URL found');
        }
      } else if (response.statusCode == 200) {
        final res = baseRequestModelFromJson(response as String);
        if (res.status == 200) {
          return AccessTokenModel.fromJson(res.data);
        } else {
          throw Exception('Failed to update access token');
        }
      } else {
        throw Exception('Failed to update access token${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
