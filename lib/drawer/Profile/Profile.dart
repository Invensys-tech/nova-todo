import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamodel.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/repositories/user.repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? user; // Nullable
  bool isLoading = true;

  Future<void> getUser() async {
    final fetchedUser = await UserRepository().fetchUserById(userId);
    setState(() {
      user = fetchedUser;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          spacing: MediaQuery.of(context).size.width * 0.07,
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 22,
                color: Color(0xff009966),
              ),
            ),
          ],
        ),

        title: Text(
          "Profile",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .025,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .065),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .12,
                vertical: MediaQuery.of(context).size.height * .01,
              ),
              height: MediaQuery.of(context).size.height * .13,
              width: MediaQuery.of(context).size.width * 1,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.userCircle, size: 55),
                  SizedBox(width: MediaQuery.of(context).size.width * .035),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user?['name'] ?? ""}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .005,
                      ),

                      Text(
                        "${user?['phoneNumber'] ?? ""}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .0015,
                      ),
                      Text(
                        "Mebmber Since ${user?['created_at'] ?? ""} ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * .055),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .065),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account Details", style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  Container(
                    height: MediaQuery.of(context).size.height * .075,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .015,
                      vertical: MediaQuery.of(context).size.height * .0015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.phone, size: 18),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .035,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            "${user?['phoneNumber'] ?? ""}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * .045,
                          width: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: Text(
                              "Change",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  Container(
                    height: MediaQuery.of(context).size.height * .075,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .015,
                      vertical: MediaQuery.of(context).size.height * .0015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.a, size: 18),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .035,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            "${user?['gender'] ?? ""}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * .045,
                          width: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: Text(
                              "Change",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .035),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account Details", style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  Container(
                    height: MediaQuery.of(context).size.height * .075,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .015,
                      vertical: MediaQuery.of(context).size.height * .0015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.phone, size: 18),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .035,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            "+251985758451",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * .045,
                          width: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: Text(
                              "Change",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .015),
                  Container(
                    height: MediaQuery.of(context).size.height * .075,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .015,
                      vertical: MediaQuery.of(context).size.height * .0015,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.a, size: 18),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .035,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            " John Welekidan",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * .045,
                          width: MediaQuery.of(context).size.width * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey.withOpacity(.4),
                          ),
                          child: Center(
                            child: Text(
                              "Change",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
