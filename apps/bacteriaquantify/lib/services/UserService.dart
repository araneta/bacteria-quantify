import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/models/User.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Config.dart';

class UserService {
  final BuildContext context;

  const UserService({required this.context});

  register(String fullName, String email, String password) async {
    Map data = {
      'fullName': fullName,
      'email': email,
      'password': password,
      'mobileNo': '000',
    };
    var jsonData = null;
    var success = false;
    var url = Config.API_HOST;
    print(jsonEncode(data));
    var response = await http.post(
      Uri.parse("$url/api/register"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );
    print(response);

    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(response.body);
      if (jsonData != null) {
        if (jsonData['status'] == 1) {
          success = true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(jsonData['message']),
            ));
          }
        }
      }
    } else {
      print('error sending;');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Response status: ${response.statusCode}, Response body: ${response.body}"),
        ));
      }
    }
    return success;
  }

  login(String email, String password) async {
    bool success = false;
    Map data = {'username': email, 'password': password};
    var jsonData = null;
    String url = Config.API_HOST;

    ///SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("url " + url + "/auth/login");
    print('login data;');
    print(data);
    try {
      var response = await http.post(
        Uri.parse("$url/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );
      print(response);

      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        print(response.body);
        if (jsonData != null) {
          print('login;');
          if (jsonData.containsKey("token")) {
            success = true;
            User userx = User(
                fullName: jsonData["fullName"],
                username: jsonData["username"],
                token: jsonData["token"]);

            UserPreferences.storeUser(userx);
            UserPreferences.setToken(jsonData['token']);
            UserPreferences.setAPIURL(url);

            success = true;
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("user name or password is incorrect"),
              ));
            }
          }
        }
      } else {
        print('sattas login;');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Response status: ${response.statusCode}, Response body: ${response.body}"),
          ));
        }
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Exception: ${e}"),
        ));
      }
    }
    return success;
  }
}
