import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/common/user.image.dart';
import 'package:flutter_application_1/components/inputs/radio.input.dart';
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: MediaQuery.of(context).size.height * 0.08,
              children: [
                // Text('Create Profile', style: TextStyle(fontSize: 24)),
                UserProfileWithAddButton(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.height * 0.018,
                  children: [
                    MyTextInput(
                      label: 'Full Name',
                      textFields: TextFields(
                        hinttext: 'Enter Name',
                        whatIsInput: "1",
                        controller: _nameController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: MyRadioInput(
                        label: 'Gender',
                        groupKey: 'gender',
                        options: ['Male', 'Female'],
                        onChanged: selectGender,
                      ),
                    ),
                    // MySelector(
                    //   myDropdownItems: [
                    //     {'label': 'Male', 'value': 'M'},
                    //     {'label': 'Female', 'value': 'F'},
                    //   ],
                    //   onSelect: selectGender,
                    //   label: 'Gender',
                    //   currentValue: _genderController.text,
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: submitProfile,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF009966), width: 2),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Color(0xFF009966).withAlpha(33),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Color(0xFF009966)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
