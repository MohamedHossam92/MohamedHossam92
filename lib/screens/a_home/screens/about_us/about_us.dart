import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

import 'list_of_data.dart';

class AboutUs extends StatelessWidget {
  static String id = 'AboutUs';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      top: true,
      right: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('رؤيتنا وهدفنا'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade300,
            child: Column(
              children: aboutUsList.map((e) {
                return Column(
                  children: [
                    Card(
                      child: Row(
                        children: [
                          DPadding(
                            child: Icon(
                              e.icon,
                              color: e.color,
                            ),
                          ),
                          DPadding(
                            val: .03,
                            child: BTextB5(e.title),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: DPadding(
                        child: Card(
                          elevation: 5,
                          child: DPadding(
                            val: .04,
                            child: BText4(
                              e.content,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
