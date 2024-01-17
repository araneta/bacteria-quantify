import 'package:bacteriaquantify/services/ConnectionService.dart';
import 'package:bacteriaquantify/services/HistoryService.dart';
import 'package:bacteriaquantify/services/PDFService.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconTextButton.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Config.dart';
import 'dart:io';

import 'SampleHistory.dart';
import 'models/Bacteries.dart';
import 'models/History.dart';
import 'models/User.dart';

class About extends StatefulWidget {
  About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User user = UserPreferences.getUser();

    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //top nav
                    width: size!.width * 0.9,

                    height: 50,
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  ;
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
                                    "About",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        color: textBlack),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  );
                                }, // Image tapped
                                child: const Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(
                                        "assets/home_24px_outlined.png")),
                              ),
                            ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: size!.width * 0.9,
                      //padding: EdgeInsets.only(top: 80, bottom: 60.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 120,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/768px-Logo_Universitas_Brawijaya 1.png"))),
                                Container(
                                    height: 120,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/logo 1 png 1.png"))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 130,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/MEKA_VISION1 1.png"))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text("Bacteria Count V1.0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text:
                                                  "Aplikasi mobile ini adalah aplikasi yang dikembangkan oleh \nKelompok Riset Bio-AI \nFakultas Teknologi Pertanian \nUniversitas Brawijaya © 2024",
                                              style: TextStyle(
                                                  height: 2,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1)),
                                            ))))
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(bottom: 58.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text:
                                                  "Kontak : mekatronika@ub.ac.id",
                                              style: TextStyle(
                                                  height: 2,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1)),
                                            ))))
                              ],
                            )
                          ])),
                ]))
      ]),
    ));
  }
}
