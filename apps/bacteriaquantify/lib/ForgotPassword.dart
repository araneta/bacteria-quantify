import 'package:bacteriaquantify/services/UserService.dart';
import 'package:bacteriaquantify/style.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final nameCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();
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
                  Image.asset(
                    'assets/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 9),
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
                    Text(
                      "Lupa Password",
                      style: TextStyle(
                        fontSize: fontSizeHeading1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Silahkan masukkan email anda yang terdaftar untuk atur ulang passwordmu",
                      style: TextStyle(
                        fontSize: fontSizeNormal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildTextField(
                        controller: usernameCtr, hint: 'Email/Username'),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('t1');
                        if (usernameCtr.text == "") {
                          print('t3');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Silahkan masukkan username/email"),
                          ));
                        } else {
                          resetPassword(usernameCtr.text);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0XFF4FA6CB),
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        )),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 42, vertical: 8),
                        ),
                      ),
                      child: Text("Kirim"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah mendaftar? ',
                          style: TextStyle(fontSize: fontSizeNormal),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                                fontSize: fontSizeNormal,
                                color: Color(0XFF4FA6CB)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
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

  resetPassword(String email) async {
    print('register;');
    setState(() {
      isLoading = true;
    });
    var success = await UserService(context: context).resetPassword(email);
    setState(() {
      isLoading = false;
    });
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Silahkan cek email anda"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Reset password gagal"),
      ));
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("login bro"),
      ));
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("user name or password is incorrect"),
        ));
      }
    }
  }
}
