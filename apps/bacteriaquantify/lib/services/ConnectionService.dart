import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/models/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Config.dart';

class ConnectionService {
  final BuildContext context;

  const ConnectionService({required this.context});
  check2() async {
    var res = await check();
    if (!res) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  check() async {
    var url = Config.API_HOST;
    print("${url}/api/test");
    var response = await http.get(
      Uri.parse("${url}/api/test"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('telo');
    if (response.statusCode == 200) {
      print('telox');
      print(response.body);
      dynamic jsonData = json.decode(response.body);
      print(jsonData['message']);
      if (jsonData['message'] == "OK") {
        return true;
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Response status: ${response.statusCode}, Response body: ${response.body}"),
        ));
      }
    }
    return false;
  }
}
