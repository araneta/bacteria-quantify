import 'package:bacteriaquantify/About.dart';
import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'ForgotPassword.dart';
import 'models/User.dart';

class AuthScreen extends StatefulWidget {
  String selectedAuth = "Masuk";
  AuthScreen({super.key, this.selectedAuth = "Masuk"});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final nameCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  bool isLoading = false;
  String selectedAuth = "Masuk";

  @override
  void initState() {
    super.initState();
    /*User user = UserPreferences.getUser();
    if (!user.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      
    }*/
    setState(() => {selectedAuth = widget.selectedAuth});
  }

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
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 9),
                  const Text(
                    'Bacteria\nCount',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textBlue,
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(37),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0X80000000),
                        blurRadius: 14,
                        offset: Offset(0, 4),
                        spreadRadius: -3)
                  ],
                ),
                child: Column(
                  children: [
                    _buildAuthType(),
                    selectedAuth == 'Masuk'
                        ? const SizedBox(height: 44)
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sudah mendaftar? ',
                                  style: TextStyle(fontSize: fontSizeNormal),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedAuth = 'Masuk';
                                    });
                                  },
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontSize: fontSizeNormal,
                                        color: textBlue),
                                  ),
                                )
                              ],
                            ),
                          ),
                    Visibility(
                      visible: selectedAuth != 'Masuk',
                      child: _buildTextField(controller: nameCtr, hint: 'Nama'),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(controller: usernameCtr, hint: 'Username'),
                    const SizedBox(height: 10),
                    _buildTextField(
                        controller: passwordCtr,
                        hint: 'Password',
                        inputType: TextInputType.visiblePassword,
                        obscrueText: true),
                    selectedAuth != 'Masuk'
                        ? const SizedBox(height: 84)
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAuth = "Daftar";
                                      });
                                    },
                                    child: Text(
                                      'Belum mendaftar?',
                                      style: TextStyle(
                                        fontSize: fontSizeNormal,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )),
                                Text(
                                  ' / ',
                                  style: TextStyle(
                                    fontSize: fontSizeNormal,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: Text(
                                    'Lupa password?',
                                    style: TextStyle(
                                      fontSize: fontSizeNormal,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        print('t1' + selectedAuth);
                        if (selectedAuth == 'Daftar') {
                          print('t2');
                          if (nameCtr.text == "" ||
                              usernameCtr.text == "" ||
                              passwordCtr.text == "") {
                            print('t3');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Silahkan isi semua field"),
                            ));
                          } else {
                            print('t4');
                            register(nameCtr.text, usernameCtr.text,
                                passwordCtr.text);
                          }
                        } else {
                          print('t5');
                          if (usernameCtr.text == "" ||
                              passwordCtr.text == "") {
                            print('t3');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Silahkan isi semua field"),
                            ));
                          } else {
                            print('t4');
                            login(usernameCtr.text, passwordCtr.text);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          textBlue,
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        )),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 15),
                        ),
                      ),
                      child: Text(
                          selectedAuth == 'Masuk' ? selectedAuth : 'Buat Akun'),
                    ),
                    SizedBox(height: 40),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => About()),
                            );
                          },
                          child: Row(children: [
                            Image(image: AssetImage("assets/info_dark.png")),
                            Text(
                              "About",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            )
                          ]))
                    ]),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildAuthType() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
        boxShadow: const [
          BoxShadow(
              color: Color(0X40000000),
              blurRadius: 16,
              offset: Offset(0, 7),
              spreadRadius: -10)
        ],
      ),
      child: Row(
        children: [
          _buildAuthTypeChoice(label: 'Masuk'),
          _buildAuthTypeChoice(label: 'Daftar')
        ],
      ),
    );
  }

  Widget _buildAuthTypeChoice({required String label}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedAuth = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: selectedAuth == label ? textBlue : Colors.white),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selectedAuth != label ? textBlue : Colors.white,
                fontSize: fontSizeHeading1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hint,
      TextInputType inputType = TextInputType.name,
      bool obscrueText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscrueText,
      keyboardType: inputType,
      decoration:
          InputDecoration(hintText: hint, border: const OutlineInputBorder()),
    );
  }

  register(String fullName, String email, String password) async {
    print('register;');
    setState(() {
      isLoading = true;
    });
    var success =
        await UserService(context: context).register(fullName, email, password);
    setState(() {
      isLoading = false;
    });
    if (success) {
      setState(() {
        selectedAuth = "Masuk";
      });
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("user name or password is incorrect"),
        ));
      }
    }
  }

  login(String email, String password) async {
    print('login;');
    setState(() {
      isLoading = true;
    });
    var success = await UserService(context: context).login(email, password);
    setState(() {
      isLoading = false;
    });
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("user name or password is incorrect"),
        ));
      }
    }
  }
}
