import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/components/inputs/otp.input.dart';
import 'package:flutter_application_1/components/inputs/text.input.dart';
import 'package:flutter_application_1/pages/auth/otp.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/notification.service.dart';
import 'package:flutter_application_1/ui/inputs/textfield.dart';
import 'package:flutter_application_1/utils/enums.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();

  // final TextEditingController _passwordController = TextEditingController();

  bool _signinError = false;
  bool isLoading = false;

  changeLoadingState(bool loadingState) {
    setState(() {
      isLoading = loadingState;
    });
  }

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
    if (isLoading) {
      return;
    }
    String phoneNumber = _phoneNumberController.text;
    changeLoadingState(true);
    AuthService()
        .signin(_phoneNumberController.text)
        .then((value) {
          navigateToSignUp(value, phoneNumber);
          setState(() {
            _signinError = false;
          });
          changeLoadingState(false);
          // Todo: store the user data
          // navigateToHome();
        })
        .catchError((error) {
          print('Invalid Credentials');
          setState(() {
            _signinError = true;
          });
          changeLoadingState(false);
        });
  }

  PhoneNumber number = PhoneNumber(isoCode: 'ET');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: MediaQuery.of(context).size.height * 0.08,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: MediaQuery.of(context).size.height * .005,
                    children: [
                      Text(
                        'Enter Your Phone Number',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: MediaQuery.of(context).size.height * .002,
                        children: [
                          Text(
                            'Please confirm your country code and enter',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'your phone number',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: MediaQuery.of(context).size.height * 0.004,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MyOTPInput(
                    //   length: 5,
                    //   onChange: (value) => print("$value"),
                    // ),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    InternationalPhoneNumberInput(
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        showFlags: true,
                        useEmoji: false,
                        // backgroundColor,
                        // this.countryComparator,
                        setSelectorButtonAsPrefixIcon: false,
                        useBottomSheetSafeArea: false,
                      ),
                      // initialValue: PhoneNumber(
                      //   phoneNumber: '+251912345678',
                      //   dialCode: '+251',
                      //   isoCode: '+251',
                      // ),
                      initialValue: number,
                      inputBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF27272A)),
                      ),
                      onInputChanged: (number) {
                        // print(phoneNumber.phoneNumber);
                        // print(phoneNumber.toString());
                        _phoneNumberController.text = number.phoneNumber ?? '';
                      },
                    ),
                    // MyTextInput(
                    //   label: 'Phone Number',
                    //   textFields: TextFields(
                    //     hinttext: 'Enter Phone Number',
                    //     whatIsInput: "0",
                    //     controller: _phoneNumberController,
                    //   ),
                    // ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: signin,
                //   style: ElevatedButton.styleFrom(
                //     side: BorderSide(
                //       width: 2,
                //       color: _signinError ? Colors.red : const Color(0xFF84E1E6),
                //     ),
                //   ),
                //   child: Text('Continue'),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: signin,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Color(0xFF009966),
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Color(0xFF009966),
                        ),
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.grey.shade300,
                                  ),
                                )
                                : Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
