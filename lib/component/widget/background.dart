import 'package:flutter/material.dart';

class AppBackGround extends StatelessWidget {
  final Widget child;

  const AppBackGround({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        height: double.infinity,
        child: child);
  }
}
