// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class AuthProvider extends ChangeNotifier {
//   String? _token;
//
//   String get token => _token!;
//
//   Future<bool> login(String username, String password) async {
//     // Make a POST request to login API
//     var url = Uri.parse('https://flutter-amr.noviindus.in/api/Login');
//     var response = await http.post(url, body: {
//       'username': username,
//       'password': password,
//     });
//
//     if (response.statusCode == 200) {
//       // Store token
//       _token = response.body;
//       notifyListeners();
//       return true;
//     } else {
//       throw Exception('Failed to login');
//     }
//   }
// }
