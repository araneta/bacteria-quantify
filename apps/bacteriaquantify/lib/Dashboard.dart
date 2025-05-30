import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconTextButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'About.dart';
import 'Preview.dart';

import 'SampleHistory.dart';
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

  @override
  void initState() {
    super.initState();
    User user = UserPreferences.getUser();
    if (user.isEmpty) {
      logout();
    }
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
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/topbg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
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
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    logout();
                                  },
                                  child: Text("Logout !",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ))),
                              SizedBox(
                                height: 6,
                              ),
                            ])
                      ],
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 60, bottom: 60.0),
                  height: MediaQuery.of(context).size.height - 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Bacteria Count',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textBlue,
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
                                  child: BigRoundIconTextButton(
                                      onTap: () async {
                                        print("take photo");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Preview(
                                                    source: 1,
                                                  )),
                                        );
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
                                  child: BigRoundIconTextButton(
                                      onTap: () async {
                                        print("insert photo");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Preview(
                                                    source: 2,
                                                  )),
                                        );
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
                                  child: BigRoundIconTextButton(
                                      onTap: () async {
                                        print("History photo");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SampleHistory()),
                                        );
                                      },
                                      icon:
                                          AssetImage("assets/history_24px.png"),
                                      title: "History")),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(bottom: 20.0, top: 4),
                                  width: 190,
                                  child: BigRoundIconTextButton(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => About()),
                                        );
                                      },
                                      icon: AssetImage("assets/info_light.png"),
                                      title: "About")),
                            ],
                          ),
                        ),
                      ])),
            ]))
      ]),
    ));
  }

  logout() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();
    UserPreferences.init();
    //sharedPref.commit();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => AuthScreen()),
        (Route<dynamic> route) => false);
  }
}
