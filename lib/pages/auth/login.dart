import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/signup.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenPage()),
    );
  }

  navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  signin() {
    AuthService()
        .signIn(_phoneNumberController.text, _passwordController.text)
        .then((value) {
          // Todo: store the user data
          navigateToHome();
        })
        .catchError((error) {
          print('Error initializing user');
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
              ElevatedButton(onPressed: signin, child: Text('Continue')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: MediaQuery.of(context).size.width * 0.05,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: navigateToSignUp,
                    child: Text('Sign up', style: TextStyle(fontSize: 18)),
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
