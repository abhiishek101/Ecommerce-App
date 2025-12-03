import 'package:ecommerce_admin_app/controllers/auth_service.dart';
import 'package:ecommerce_admin_app/firebase_options.dart';
import 'package:ecommerce_admin_app/views/admin_home.dart';
import 'package:ecommerce_admin_app/views/login.dart';
import 'package:ecommerce_admin_app/views/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 246, 227, 19),
        ),
        useMaterial3: true,
      ),
      //routes are basically the pages/screens in your app, and they help you navigate between them.
      routes: {
        "/": (context) => LoginPage(),
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignupPage(),
        "/home": (context) => AdminHome(),
      },
    );
  }
}

class _CheckUserState extends StatefulWidget {
  const _CheckUserState({super.key});

  @override
  State<_CheckUserState> createState() => __CheckUserStateState();
}

class __CheckUserStateState extends State<_CheckUserState> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
