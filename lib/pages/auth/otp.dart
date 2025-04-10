import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/create-profile.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/enums.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  final loginRoutes action;
  const OTPPage({
    super.key,
    this.action = loginRoutes.SIGNUP,
    required this.phoneNumber,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController = TextEditingController();

  navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenPage()),
    );
  }

  navigateToCreateProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProfile(phoneNumber: widget.phoneNumber),
      ),
    );
  }

  navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInPage()),
    );
  }

  handleVerify() {
    AuthService().verifyOTP(widget.phoneNumber, _otpController.text).then((
      value,
    ) {
      if (value) {
        if (widget.action == loginRoutes.SIGNUP) {
          navigateToCreateProfile();
        } else {
          navigateToHome();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: MediaQuery.of(context).size.height * 0.08,
            children: [
              Text('Send OTP', style: TextStyle(fontSize: 24)),
              Column(
                spacing: MediaQuery.of(context).size.height * 0.05,
                children: [
                  MyTextInput(
                    label: 'OTP',
                    textFields: TextFields(
                      hinttext: 'Enter OTP',
                      whatIsInput: "1",
                      controller: _otpController,
                    ),
                  ),
                  // MyTextInput(
                  //   label: 'Password',
                  //   textFields: TextFields(
                  //     hinttext: 'Enter Password',
                  //     whatIsInput: "1",
                  //     controller: _passwordController,
                  //   ),
                  // ),
                ],
              ),
              ElevatedButton(onPressed: handleVerify, child: Text('Continue')),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   spacing: MediaQuery.of(context).size.width * 0.05,
              //   children: [
              //     Text(
              //       'Already have an account?',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     TextButton(
              //       onPressed: navigateToLogin,
              //       child: Text('Sign In', style: TextStyle(fontSize: 18)),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
