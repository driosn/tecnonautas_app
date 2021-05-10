import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tecnonautas_app/src/pages/init/init_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 4),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => InitPage() 
        ),
        (route) => false
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEAEC),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_screen.gif")
            )
          ),
        )
      ),
    );
  }
}