import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:machine_test/constant/colors.dart';
import 'package:machine_test/widgets/App%20Text.dart';
import 'package:machine_test/widgets/App%20container.dart';
import 'package:machine_test/widgets/Text%20FormField.dart';

import '../provider/Login Provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 254,
                width: double.infinity,
                child: Image.asset(
                  'assets/splach.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: SizedBox(
                    width: 80,
                    height: 84,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: loginProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login or register to book your appointments ',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: grayblack,
                    ),
                  ),
                  SizedBox(height: 30),
                  AppText(
                    text: 'Username',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack,
                  ),
                  SizedBox(height: 5),
                  AppTextForm(
                    hintText: 'Enter your Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                    controller: loginProvider.usernameController,
                  ),
                  SizedBox(height: 20),
                  AppText(
                    text: 'Password',
                    size: 16,
                    weight: FontWeight.w400,
                    textcolor: grayblack,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: loginProvider.passwordController,
                    obscureText: loginProvider.passToggle,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F1F1),
                      filled: true,
                      hintText: 'Enter Password',
                      hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      suffix: InkWell(
                        onTap: loginProvider.togglePasswordVisibility,
                        child: Icon(
                          loginProvider.passToggle
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 80),
                  loginProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () => loginProvider.login(context),
                          child: MyContainer(
                            text: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'By creating or logging into an account you are agreeing with our ',
                          style: GoogleFonts.poppins(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: GoogleFonts.poppins(
                            color: Color(0xff0028FC),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: GoogleFonts.poppins(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: GoogleFonts.poppins(
                            color: Color(0xff0028FC),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
