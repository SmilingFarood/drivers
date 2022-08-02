import 'dart:convert';
import 'dart:io';

import 'package:drivers/connection/url_constants.dart';
import 'package:drivers/models/driver.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriversProvider extends ChangeNotifier {
  //

  final List<Driver> _drivers = [];
  List<Driver> get drivers {
    return [..._drivers];
  }

  Future getAllDrivers({required String token}) async {
    final getAllDriversUrl = Uri.parse(
        '${UrlConstants.getAllDriversUrl}?count=true&companyId=${AppConstants.companyId}');
    try {
      final http.Response res = await http.get(
        getAllDriversUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode != 200) {
        throw const HttpException('An Error Occured');
      }
      final resData = json.decode(res.body);
      _drivers.clear();
      resData.forEach((val) {
        _drivers.add(
          Driver(
            name: val['name'],
            phone: val['phone'],
            email: val['email'],
            code: val['code'],
            address: val['address'],
            city: val['city'],
            state: val['state'],
            userId: val['userId'],
            driverLicense: val['driverLicense'],
            companyId: val['companyId'],
            dateAdded: val['dateAdded'] == null
                ? null
                : DateTime.parse(val['dateAdded']),
            companyName: val['companyName'],
            assigned: val['assigned'],
            vehicleAssigned: val['vehicleAssigned'],
            // roles: val['roles'],
            walletId: val['walletId'],
            walletUnit: val['walletUnit'],
            walletFriendlyName: val['walletFriendlyName'],
            // vehicles: ['vehicles'],
            id: val['id'],
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      //
    }
  }

  Future<String> addDrivers({required AddDriverReq addDriverReq}) async {
    String message = '';
    final addDriverUrl =
        Uri.parse(UrlConstants.addDriverUrl + AppConstants.companyId);

    try {
      final http.Response res = await http.post(
        addDriverUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${addDriverReq.token}',
        },
        body: json.encode({
          'companyId': addDriverReq.companyId,
          'userId': addDriverReq.userId,
          'name': addDriverReq.name,
          'phone': addDriverReq.phone,
          'email': addDriverReq.email,
          'address': addDriverReq.address,
          'city': addDriverReq.city,
          'state': addDriverReq.state,
          'roles': addDriverReq.roles,
        }),
      );
      // print(res.statusCode);
      // print(res.body);
      if (res.statusCode != 200) {
        final err = json.decode(res.body);
        throw HttpException(err['message']);
      }
      final resData = json.decode(res.body);
      message = resData['message'];
    } catch (e) {
      rethrow;
    }
    return message;
  }

  Future<String> deleteDriver(
      {required String driverId, required String token}) async {
    String message = '';
    final deleteDriverUrl = Uri.parse(
        '${UrlConstants.deleteDriverUrl}${AppConstants.companyId}/$driverId');

    try {
      final http.Response res = await http.delete(
        deleteDriverUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200) {
        message = '';
        throw message;
      }
      final resData = json.decode(res.body);
      message = resData['message'];
    } catch (e) {
      //
    }
    return message;
  }

  Future<String> editDriver({required EditDriverReq editDriverReq}) async {
    String message = '';
    final editDriverUrl = Uri.parse(
        '${UrlConstants.editDriver}${editDriverReq.companyId}/${editDriverReq.driverId}');

    final http.Response res = await http.put(
      editDriverUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${editDriverReq.token}',
      },
      body: json.encode({
        'companyId': editDriverReq.companyId,
        'userId': editDriverReq.userId,
        'name': editDriverReq.name,
        'phone': editDriverReq.phone,
        'email': editDriverReq.email,
        'address': editDriverReq.address,
        'city': editDriverReq.city,
        'state': editDriverReq.state,
        'roles': editDriverReq.roles
      }),
    );

    if (res.statusCode != 200) {
      final err = json.decode(res.body);
      throw HttpException(err['message']);
    }
    final resData = json.decode(res.body);
    message = resData['message'];

    return message;
  }
}
