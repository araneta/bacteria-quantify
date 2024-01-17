import 'dart:convert';
import 'dart:io';
import 'package:bacteriaquantify/DetailHistory.dart';
import 'package:bacteriaquantify/models/DetectionResultResponse.dart';
import 'package:bacteriaquantify/services/ConnectionService.dart';
import 'package:bacteriaquantify/services/HistoryService.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bacteriaquantify/Dashboard.dart';

import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:flutter/material.dart';

import 'Config.dart';

import 'models/History.dart';
import 'models/User.dart';

class SampleHistory extends StatefulWidget {
  const SampleHistory({super.key});

  @override
  State<SampleHistory> createState() => _SampleHistoryState();
}

class _SampleHistoryState extends State<SampleHistory> {
  bool isDone = false;
  bool isConnected = false;
  var _isLoading = false;

  var histories = <History>[];
  @override
  void initState() {
    super.initState();

    ConnectionService(context: context).check().then((res) {
      setState(() {
        isConnected = res;
      });
    });
    getHistories();
  }

  getHistories() async {
    setState(() {
      _isLoading = true;
    });
    var newhistories = await HistoryService(context: context).getHistories();

    setState(() {
      _isLoading = false;
      histories = newhistories;
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
                                    "History",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        color: textBlack),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: size!.width * 0.9,
                      //padding: EdgeInsets.only(top: 80, bottom: 60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...histories.asMap().entries.map((sample) {
                            var imageURL =
                                "${Config.DETECTOR_API_IMAGE_BASE_URL}/${sample.value.localFileImage!}.jpg";
                            return InkWell(
                              onTap: () {
                                print("dasdsad");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DetailHistory(history: sample.value)));
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  /*
                                            height: 30,*/
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  decoration: BoxDecoration(
                                    color: textBlue,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CachedNetworkImage(
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            progressIndicatorBuilder: (context,
                                                    url, progress) =>
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: progress.progress,
                                                  ),
                                                ),
                                            imageUrl: imageURL,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                                      width: 99,
                                                      height: 84,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  20), //apply padding to all four sides
                                          child: Text(sample.value.sampleName!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                        ),
                                      ])),
                            );
                          }),
                        ],
                      )),
                ]))
      ]),
    ));
  }

  Widget buildHistoryItem({required int index}) {
    final hist = histories[index];
    var imgUrl = hist.localFileImage!;
    return InkWell(
      onTap: () {
        print('selected ${index}');
      },
      child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          width: 170,
          /*
                                            height: 30,*/
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(63, 193, 145, 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: NetworkImage(imgUrl)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 6), //apply padding to all four sides
                    child: Text("Sampel Bakteri A",
                        style: TextStyle(color: Colors.white)),
                  ),
                ]),
          )),
    );
  }
}
