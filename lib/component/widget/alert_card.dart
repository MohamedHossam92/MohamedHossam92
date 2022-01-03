import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class AlertCard extends StatelessWidget {
  final String title;

  const AlertCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade900,
      child: DPadding(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.policy_sharp,
            color: Colors.white,
            size: MediaQuery.of(context).size.width * .05,
          ),
          YTextB5('إضغط هنا'),
          WTextB5(title),
        ],
      )),
    );
  }
}
