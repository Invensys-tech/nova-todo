import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/quil.dart';

class QuilPage extends StatefulWidget {
  const QuilPage({super.key});

  @override
  State<QuilPage> createState() => _QuilPageState();
}

class _QuilPageState extends State<QuilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.abc),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [QuilExample()]),
      ),
    );
  }
}
