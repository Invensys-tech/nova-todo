import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/testgoal.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: []),
      ),
    );
  }
}
