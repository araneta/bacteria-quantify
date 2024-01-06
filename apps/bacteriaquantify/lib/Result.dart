import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:path/path.dart' as Path;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundButton.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:bacteriaquantify/utils/Media.dart';
import 'package:bacteriaquantify/utils/MultipartRequest.dart';
import 'package:oktoast/oktoast.dart';
import 'Config.dart';
import 'auth_screen.dart';
import 'models/DetactionResult.dart';
import 'models/User.dart';

class Result extends StatefulWidget {
  final DetectionResult detectionResult;
  Result({required this.detectionResult});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String imageURL = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      imageURL = Config.API_HOST +
          "/userImages/" +
          widget.detectionResult.message!.imageID! +
          ".jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User user = UserPreferences.getUser();

    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                //top nav
                width: size!.width * 0.9,

                height: 50,
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 40.0, top: 10, bottom: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                            }, // Image tapped
                            child: const Image(
                                width: 30,
                                height: 30,
                                image: AssetImage(
                                    "assets/arrow_back_ios_24px.png")),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                "Result",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    color: textBlue),
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                            }, // Image tapped
                            child: const Image(
                                width: 30,
                                height: 30,
                                image: AssetImage(
                                    "assets/home_24px_outlined.png")),
                          ),
                        ])),
              ),
              Container(
                  width: size!.width * 0.9,
                  //padding: EdgeInsets.only(top: 80, bottom: 60.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*AspectRatio(
                          aspectRatio: 1,
                          child: buildImage(),
                        ),*/
                        Container(
                          alignment: Alignment.center, // use aligment
                          child: Image.network(imageURL,
                              height: 69, width: 134, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 24),
                      ])),
            ]))
      ]),
    ));
  }
}
