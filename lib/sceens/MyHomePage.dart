import 'dart:async';
import 'package:flutter/material.dart';
import 'package:machine_test/sceens/Login%20page.dart';

import '../constant/colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/splach.png',
                fit: BoxFit.cover,
              )),
          Center(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
