// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class LoginService {
//   static const String apiUrl = 'https://flutter-amr.noviindus.in/api/Login'; // Replace with your API URL
//
//   Future<String?> login(String username, String password) async {
//     try {
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         // Assuming the token is in the 'token' field of the response
//         return jsonResponse['token'];
//       } else {
//         // Handle errors here
//         print('Login failed with status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('An error occurred: $e');
//       return null;
//     }
//
//
//   }
// }
