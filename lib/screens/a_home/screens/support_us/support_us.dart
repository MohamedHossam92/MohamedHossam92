import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/widget/adv_slider.dart';

class SupportUs extends StatelessWidget {
  static String id = 'SupportUs';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey.shade300,
          height: size.height * .9,
          child: SingleChildScrollView(
            child: Column(children: newAdvList(context)),
          ),
        ),
      ),
    );
  }
}
