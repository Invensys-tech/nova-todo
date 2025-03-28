import 'package:flutter/widgets.dart';

class MyExpansionPanelHeader extends StatelessWidget {
  final String title;

  const MyExpansionPanelHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xff2F2F2F),
      child: Text(title),
    );
  }
}
