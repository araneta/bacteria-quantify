import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/models/User.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Config.dart';
import '../models/DetectionResult.dart';

class HistoryService {
  final BuildContext context;

  const HistoryService({required this.context});

  saveHistory(String sampleName, DetectionResult detectionResult) async {
    Map data = {
      'sampleName': sampleName,
      'localFileImage': detectionResult.imageID,
      'details': detectionResult.bacteries!.map((v) => v.toJson()).toList()
    };
    var jsonData = null;
    var success = false;
    User user = UserPreferences.getUser();
    var url = Config.API_HOST;
    print(jsonEncode(data));
    try {
      var response = await http.post(
        Uri.parse("$url/api/histories"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.token}"
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Saved!"),
            ));
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
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ex.toString()),
        ));
      }
    }

    return success;
  }
}
