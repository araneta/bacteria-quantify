import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/widgets/BigRoundIconButton.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final usernameCtr = TextEditingController();

  bool isLoading = false;
  String selectedAuth = "Masuk";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 54),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 20.0, top: 4),
                        width: 190,
                        child: BigRoundIconButton(
                            onTap: () async {
                              print("take photo");
                            },
                            icon: AssetImage("add_a_photo_24px.png"),
                            title: "Take a Photo")),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 20.0, top: 4),
                        width: 190,
                        child: BigRoundIconButton(
                            onTap: () async {
                              print("insert photo");
                            },
                            icon: AssetImage("add_photo_alternate_24px.png"),
                            title: "Insert Photo")),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 20.0, top: 4),
                        width: 190,
                        child: BigRoundIconButton(
                            onTap: () async {
                              print("History photo");
                            },
                            icon: AssetImage("history_24px.png"),
                            title: "History")),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
