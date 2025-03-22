import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';

class HomePage extends StatelessWidget {
  final Datamanager datamanager;
  const HomePage({super.key, required this.datamanager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Removes the AppBar space
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "asdfasdf", // Change this to your desired title
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true, // Centers the title
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.rotate_right_rounded),
        // ),
      ),
    );
  }
}
