import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/constant/colors.dart';

import '../sceens/Home.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passToggle = true;

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('https://flutter-amr.noviindus.in/api/Login'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['token'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful'),backgroundColor: green,),
      );

      // Delaying navigation to ensure the snackbar is shown
      await Future.delayed(Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PatientListPage(token: token),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed'),backgroundColor: Colors.red,),
      );
    }
  }

  void togglePasswordVisibility() {
    passToggle = !passToggle;
    notifyListeners();
  }
}
