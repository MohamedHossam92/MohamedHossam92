import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

SnackBar dSnackBarShowResult({icon, title}) {
  return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: Duration(milliseconds: 1200),
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          WTextB4(title)
        ],
      ));
}
