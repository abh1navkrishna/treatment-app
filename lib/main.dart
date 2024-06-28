import 'package:flutter/material.dart';
import 'package:machine_test/provider/Login%20Provider.dart';
import 'package:machine_test/provider/patient%20list%20provider.dart';
import 'package:machine_test/sceens/MyHomePage.dart';
import 'package:provider/provider.dart';
import 'demo/patient list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TreatmentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
