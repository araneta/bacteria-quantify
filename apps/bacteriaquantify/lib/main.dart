import 'package:bacteriaquantify/Dashboard.dart';
import 'package:bacteriaquantify/auth_screen.dart';
import 'package:bacteriaquantify/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'models/User.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  await UserPreferences.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://ea98d019c31d44ff856075ded29c2251@o89294.ingest.sentry.io/4504236923944960';
      options.tracesSampleRate = 1.0;
    },
    // Init your App.
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User user = UserPreferences.getUser();

    return MaterialApp(
      title: 'Bacteria Quantify',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: user.isEmpty ? const MyHomePage() : const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: const Color(0XFFF4F9FA),
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 249,
                height: 249,
              ),
              const SizedBox(
                height: 8,
                width: double.infinity,
              ),
              const Text(
                'Bacteria\nQuantify!',
                style: TextStyle(
                    color: Color(0XFF4FA6CB),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
