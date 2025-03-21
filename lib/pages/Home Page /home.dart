import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
