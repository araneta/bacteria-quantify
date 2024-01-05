import 'dart:io';

import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:image_picker/image_picker.dart';
import 'package:extended_image/extended_image.dart';

import 'package:oktoast/oktoast.dart';
import 'auth_screen.dart';
import 'models/User.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final usernameCtr = TextEditingController();

  bool isLoading = false;
  String selectedAuth = "Masuk";
  ImageProvider provider = ExtendedExactAssetImageProvider(
    'assets/home_24px.png',
    cacheRawData: true,
  );

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
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/top-pattern.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                    padding: EdgeInsets.only(left: 40.0, top: 20, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Selamat Datang!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: 6,
                          ),
                          Text(user.fullName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                        ])),
              ),
              Container(
                  padding: EdgeInsets.only(top: 80, bottom: 60.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Bacteria\nQuantify!',
                              style: TextStyle(
                                  color: Color(0XFF4FA6CB),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 44),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 13),
                          child: Column(
                            children: [
                              Container(
                                  padding:
                                      EdgeInsets.only(bottom: 20.0, top: 4),
                                  width: 190,
                                  child: BigRoundIconButton(
                                      onTap: () async {
                                        print("take photo");
                                        _pick();
                                      },
                                      icon: AssetImage(
                                          "assets/add_a_photo_24px.png"),
                                      title: "Take a Photo")),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(bottom: 20.0, top: 4),
                                  width: 190,
                                  child: BigRoundIconButton(
                                      onTap: () async {
                                        print("insert photo");
                                      },
                                      icon: AssetImage(
                                          "assets/add_photo_alternate_24px.png"),
                                      title: "Insert Photo")),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(bottom: 20.0, top: 4),
                                  width: 190,
                                  child: BigRoundIconButton(
                                      onTap: () async {
                                        print("History photo");
                                      },
                                      icon:
                                          AssetImage("assets/history_24px.png"),
                                      title: "History")),
                            ],
                          ),
                        ),
                      ])),
            ]))
      ]),
    ));
  }

  Future<void> _pick() async {
    final XFile? result = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (result == null) {
      showToast('The pick file is null');
      return;
    }
    print(result.path);
    provider = ExtendedFileImageProvider(File(result.path), cacheRawData: true);
    setState(() {});
  }
}
