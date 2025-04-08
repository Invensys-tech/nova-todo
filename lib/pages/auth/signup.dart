import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/create-profile.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  navigateToCreateProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                CreateProfile(phoneNumber: _phoneNumberController.text),
      ),
    );
  }

  navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInPage()),
    );
  }

  signup() {
    AuthService()
        .signUp(_phoneNumberController.text, _passwordController.text)
        .then((value) {
          navigateToCreateProfile();
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
              Text('Sign Up', style: TextStyle(fontSize: 24)),
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
                  MyTextInput(
                    label: 'Password',
                    textFields: TextFields(
                      hinttext: 'Enter Password',
                      whatIsInput: "1",
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: signup, child: Text('Continue')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: MediaQuery.of(context).size.width * 0.05,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: navigateToLogin,
                    child: Text('Sign In', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
