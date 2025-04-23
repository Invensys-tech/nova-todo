import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/otp.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/create-profile.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/enums.dart';
import 'package:flutter_application_1/utils/helpers.dart';

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: MediaQuery.of(context).size.height * 0.08,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    spacing: MediaQuery.of(context).size.height * 0.01,
                  children: [
                    Text(
                      'Please enter the 5 digit code sent to',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: MediaQuery.of(context).size.width * 0.03,
                      children: [
                        Text(
                          formatPhoneNumberToShowable(widget.phoneNumber),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF009966),
                          ),
                        ),
                        Icon(Icons.edit, color: Color(0xFF009966), size: 16),
                      ],
                    ),
                    Text('Resend SMS 0:59', style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF52525C),
                    ))
                  ]
                ),
                // Text('Send OTP', style: TextStyle(fontSize: 24)),
                Column(
                  spacing: MediaQuery.of(context).size.height * 0.005,
                  children: [
                    MyOTPInput(length: 5, onChange: (value) {_otpController.text = value;}),
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
      ),
    );
  }
}
