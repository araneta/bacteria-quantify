import 'package:bacteriaquantify/services/ConnectionService.dart';
import 'package:bacteriaquantify/services/HistoryService.dart';
import 'package:bacteriaquantify/services/PDFService.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconTextButton.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'Config.dart';
import 'dart:io';
import 'package:document_file_save_plus/document_file_save_plus.dart' as dfs;

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'SampleHistory.dart';
import 'models/Bacteries.dart';
import 'models/History.dart';
import 'models/User.dart';

class DetailHistory extends StatefulWidget {
  final History history;
  DetailHistory({required this.history});

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  String imageURL = "";
  bool isLoading = false;
  bool isConnected = false;
  var bacteries = <Bacteries>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      imageURL =
          "${Config.API_HOST}/userImages/${widget.history.localFileImage!}.jpg";
    });

    ConnectionService(context: context).check().then((res) {
      setState(() {
        isConnected = res;
      });
    });
    getDetailHistories();
  }

  getDetailHistories() async {
    setState(() {
      isLoading = true;
    });
    var newbacteries = await HistoryService(context: context)
        .getDetailHistory(widget.history.iD!);

    setState(() {
      isLoading = false;
      bacteries = newbacteries;
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SampleHistory()),
                                  );
                                }, // Image tapped
                                child: const Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage(
                                        "assets/arrow_back_ios_24px.png")),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(
                                    widget.history.sampleName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                        color: textBlue),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*AspectRatio(
                          aspectRatio: 1,
                          child: buildImage(),
                        ),*/
                            Container(
                              alignment: Alignment.center, // use aligment
                              child: Image.network(imageURL,
                                  //height: 320,
                                  width: size!.width * 0.8,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Table(
                                children: [
                                  //This table row is for the table header which is static
                                  TableRow(children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(
                                          "Bacteria Species",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0,
                                              color: textBlue),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(
                                          "Total Colony",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0,
                                              color: textBlue),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  // Using the spread operator to add the remaining table rows which have dynamic data
                                  // Be sure to use .asMap().entries.map if you want to access their indexes and objectName.map() if you have no interest in the items index.

                                  ...bacteries!.asMap().entries.map(
                                    (bacteria) {
                                      return TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Text(
                                                    bacteria.value.species!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.0,
                                                        color: textBlue)),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Text(
                                                    bacteria.value.totalColony
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.0,
                                                        color: textBlue)),
                                              ),
                                            ),
                                          ]);
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 60,
                                        child: SizedBox(
                                          height: 10,
                                        )),
                                    Container(
                                        width: 200,
                                        child: BigRoundIconTextButton(
                                            onTap: () async {
                                              print("share");
                                              share();
                                            },
                                            icon: AssetImage(
                                                "assets/share_24px.png"),
                                            title: "Share")),
                                    Container(
                                        width: 60,
                                        child: SizedBox(
                                          height: 10,
                                        ))
                                  ]),
                            )
                          ])),
                ]))
      ]),
    ));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  share() async {
    print('share;');
    setState(() {
      isLoading = true;
    });
    print("generate pdf");
    //try {
    //https://stackoverflow.com/questions/54379206/flutter-create-directory-on-external-storage-path-path-provider-getexternals
    var pdfBytes = await PDFService(context: context)
        .generateShareResult(widget.history.sampleName!, imageURL, bacteries);
    //print("get external dir");
    //final directory = await getExternalStorageDirectory();
    final directory = await _localPath;

    print("create file");
    final fname = "example.pdf";
    final fpath = "${directory}/${fname}";
    final file = File(fpath);
    print("write");
    await file.writeAsBytes(pdfBytes.toList());
    print("save");
    //dfs.DocumentFileSavePlus().saveFile(pdfBytes, fname, "application/pdf");
    print("share");
    final result =
        await Share.shareXFiles([XFile(fpath)], text: 'Great picture');

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
    //} catch (ex) {
    //print(ex);
    //}

    setState(() {
      isLoading = false;
    });
  }
}
