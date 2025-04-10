import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/otp.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/enums.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  bool _signinError = false;

  navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenPage()),
    );
  }

  navigateToSignUp(loginRoutes value, String phoneNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPPage(phoneNumber: phoneNumber, action: value),
      ),
    );
  }

  signin() {
    String phoneNumber = _phoneNumberController.text;
    AuthService()
        .signin(_phoneNumberController.text)
        .then((value) {
          navigateToSignUp(value, phoneNumber);
          setState(() {
            _signinError = false;
          });
          // Todo: store the user data
          // navigateToHome();
        })
        .catchError((error) {
          print('Invalid Credentials');
          setState(() {
            _signinError = true;
          });
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
              Text('Log In', style: TextStyle(fontSize: 24)),
              Column(
                spacing: MediaQuery.of(context).size.height * 0.05,
                children: [
                  MyTextInput(
                    label: 'Phone Number',
                    textFields: TextFields(
                      hinttext: 'Enter Phone Number',
                      whatIsInput: "0",
                      controller: _phoneNumberController,
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
              ElevatedButton(
                onPressed: signin,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 2,
                    color: _signinError ? Colors.red : const Color(0xFF84E1E6),
                  ),
                ),
                child: Text('Continue'),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   spacing: MediaQuery.of(context).size.width * 0.05,
              //   children: [
              //     Text(
              //       'Don\'t have an account?',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     TextButton(
              //       onPressed: navigateToSignUp,
              //       child: Text('Sign up', style: TextStyle(fontSize: 18)),
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
