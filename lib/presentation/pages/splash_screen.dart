import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:vindhi_app/presentation/pages/client_app/home/client_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateOnNextScreen();
  }

  Future<void> _navigateOnNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, ClientHomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            //height: MediaQuery.of(context).size.height * 0.6,
            child: Image.asset('assets/app_logo.png'),
          ),
        ),
      ),
    );
  }
}
