// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class PatientListProvider extends ChangeNotifier {
//   List<String> patients = [];
//
//   Future<void> fetchPatientList(String token) async {
//     var url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');
//     var response = await http.get(url, headers: {
//       'Authorization': 'Bearer $token',
//     });
//
//     if (response.statusCode == 200) {
//       // Parse response and update patients list
//       // Example: patients = parseResponse(response.body);
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load patients');
//     }
//   }
// }
