import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyExpansionPanelHeader extends StatelessWidget {
  final String title;
  final Icon? icon;

  const MyExpansionPanelHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(
          //   vertical: MediaQuery.of(context).size.height * 0.01,
          // ),
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          color: Theme.of(context).primaryColorDark,
          child: Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            children: [icon ?? Container(), Text(title)],
          ),
        ),

      ],
    );
  }
}
