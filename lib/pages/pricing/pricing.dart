import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/services/chapa.service.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../main.dart';
import '../../utils/helpers.dart';

class PricingScreen extends StatefulWidget {
  final bool canNavigateBack;
  const PricingScreen({Key? key, this.canNavigateBack = false}) : super(key: key);

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  bool isPaid = false;
  ChapaService chapaService = ChapaService();
  final Future<Duration> expirationTime = AuthService().getExpirationTime();

  @override
  void initState() {
    super.initState();

    print("can navigate back");
    print(widget.canNavigateBack);
  }

  handleMakePayment() {
    chapaService.makePayment(context);
  }

  verifyPayment() async {
    // bool isPaid = await chapaService.verifyPayment();
    if (isPaid) {
      dynamic session = await AuthService().findSession();
      await UserRepository().addSubscription(null, session['phoneNumber']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreenPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: widget.canNavigateBack ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ) : Icon(Icons.wallet),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translate("Pricing"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  translate("ETB "),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const Text(
                  "1,000",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    decorationThickness: 2,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  translate("Yearly"),
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     "Pricing",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              translate("Get the full experience of"),
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Vita ',
                    style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Board',
                    style: TextStyle(
                      color: Color(0xFF009966),
                      fontSize: 32,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            ...[
              translate("Plan Your Daily Movement "),
              translate("Control your  Time and Focus on your Goal"),
              translate("Build and Develop new Habit"),
              translate("Improve your productivity"),
              translate("Save your Interesting Quotes"),
              translate("Be Better that the thing you are now"),
            ].map(
              (text) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF00D084)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(text, style: TextStyle(fontSize: 20))),
                  ],
                ),
              ),
            ),
            const Spacer(),
            FutureBuilder(
              future: expirationTime,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.inDays < 4) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00D084),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          handleMakePayment();
                          // Action on Continue
                        },
                        child: Text(
                          translate('Continue'),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'PAYMENT UP TO DATE!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00D084),
                        ),
                      ),
                    );
                  }
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Expiration time not set!'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
            const Spacer(),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF00D084),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       padding: const EdgeInsets.symmetric(vertical: 14),
            //     ),
            //     onPressed: () {
            //       verifyPayment();
            //       // Action on Continue
            //     },
            //     child: const Text(
            //       'Verify',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translate('3-Day '), style: TextStyle(fontSize: 20)),
                  Text.rich(
                    TextSpan(
                      text: translate('Free Trial'),
                      style: TextStyle(
                        color: Color(0xFF00D084),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
