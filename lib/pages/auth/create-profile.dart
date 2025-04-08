import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/selector.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';

class CreateProfile extends StatefulWidget {
  final String phoneNumber;
  const CreateProfile({super.key, required this.phoneNumber});

  @override
  State<CreateProfile> createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenPage()),
    );
  }

  selectGender(value) {
    _genderController.text = value;
  }

  submitProfile() {
    AuthService()
        .initializeUser(
          widget.phoneNumber,
          _nameController.text,
          _genderController.text,
          _otpController.text,
        )
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
              Text('Create Profile', style: TextStyle(fontSize: 24)),
              Column(
                spacing: MediaQuery.of(context).size.height * 0.05,
                children: [
                  MyTextInput(
                    label: 'Name',
                    textFields: TextFields(
                      hinttext: 'Enter Name',
                      whatIsInput: "1",
                      controller: _nameController,
                    ),
                  ),
                  MySelector(
                    myDropdownItems: [
                      {'label': 'Male', 'value': 'M'},
                      {'label': 'Female', 'value': 'F'},
                    ],
                    onSelect: selectGender,
                    label: 'Gender',
                    currentValue: _genderController.text,
                  ),
                  MyTextInput(
                    label: 'OTP',
                    textFields: TextFields(
                      hinttext: 'Enter OTP',
                      whatIsInput: "1",
                      controller: _otpController,
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: submitProfile, child: Text('Continue')),
            ],
          ),
        ),
      ),
    );
  }
}
