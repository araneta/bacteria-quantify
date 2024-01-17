import 'package:bacteriaquantify/SampleHistory.dart';
import 'package:bacteriaquantify/services/HistoryService.dart';
import 'package:bacteriaquantify/services/PDFService.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconTextButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'Config.dart';
import 'models/DetectionResult.dart';
import 'models/User.dart';

class Result extends StatefulWidget {
  final DetectionResult detectionResult;
  Result({required this.detectionResult});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController sampleNameController = TextEditingController();
  String imageURL = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      imageURL =
          "${Config.DETECTOR_API_IMAGE_BASE_URL}/${widget.detectionResult.imageID!}.jpg";
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
                                            const Dashboard()),
                                  );
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
                  const SizedBox(
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
                              child: /*Image.network(imageURL,
                                  //height: 320,
                                  width: size!.width * 0.8,
                                  fit: BoxFit.cover)*/
                                  CachedNetworkImage(
                                      progressIndicatorBuilder: (context, url,
                                              progress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                            ),
                                          ),
                                      imageUrl: imageURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            width: size!.width * 0.8,
                                            height: 240,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.only(bottom: 20.0, top: 4),
                              //width: size!.width * 0.9,
                              child: TextFormField(
                                autocorrect: false,
                                controller: sampleNameController,
                                decoration: const InputDecoration(
                                  fillColor: Color.fromRGBO(196, 231, 246, 1),
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  labelText: "Masukan Nama Sampel...",
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(128, 179, 200, 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
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

                                  ...widget.detectionResult.bacteries!
                                      .asMap()
                                      .entries
                                      .map(
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
                                        child: BigRoundIconButton(
                                          onTap: () async {
                                            print("Share");
                                            if (sampleNameController.text ==
                                                "") {
                                              print('t3');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please enter sample name"),
                                              ));
                                            } else {
                                              share();
                                            }
                                          },
                                          icon: AssetImage(
                                              "assets/share_24px.png"),
                                        )),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: BigRoundIconTextButton(
                                            onTap: () async {
                                              print("Save");
                                              if (sampleNameController.text ==
                                                  "") {
                                                print('t3');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please enter sample name"),
                                                ));
                                              } else {
                                                saveResult();
                                              }
                                            },
                                            icon: AssetImage(
                                                "assets/save_alt_24px_outlined.png"),
                                            title: "Save")),
                                    Container(
                                        width: 60,
                                        child: BigRoundIconButton(
                                          onTap: () async {
                                            print("History");
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SampleHistory()),
                                            );
                                          },
                                          icon: AssetImage(
                                              "assets/history_24px.png"),
                                        ))
                                  ]),
                            )
                          ])),
                ]))
      ]),
    ));
  }

  share() async {
    print('share;');
    setState(() {
      isLoading = true;
    });
    print("generate pdf");
    //try {

    await PDFService(context: context).share(
        sampleNameController.text, imageURL, widget.detectionResult.bacteries!);

    setState(() {
      isLoading = false;
    });
  }

  saveResult() async {
    print('login;');
    setState(() {
      isLoading = true;
    });
    var success = await HistoryService(context: context)
        .saveHistory(sampleNameController.text, widget.detectionResult);
    setState(() {
      isLoading = false;
    });
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SampleHistory()),
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to save"),
        ));
      }
    }
  }
}
