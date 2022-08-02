import 'dart:convert';
import 'dart:io';

import 'package:drivers/connection/url_constants.dart';
import 'package:drivers/models/auth_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  User? user;

  Future login({required LoginReq loginReq}) async {
    final loginUrl = Uri.parse(UrlConstants.login);
    try {
      final http.Response res = await http.post(
        loginUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': loginReq.email,
          'password': loginReq.password,
        }),
      );
      // print(res.statusCode);
      // print(res.body);
      if (res.statusCode != 200) {
        final err = json.decode(res.body);
        throw HttpException(err['message']);
      }
      final resData = json.decode(res.body);
      user = User(
        token: resData['token'],
        expDate: resData['expDate'],
        fullName: resData['fullName'],
        email: resData['email'],
        phone: resData['phone'],
        roles: resData['roles'],
        userId: resData['userId'],
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
