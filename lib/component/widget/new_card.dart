import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

newCard() {
  return Container(
      color: Colors.yellow,
      child: SPadding(v: .001, h: .015, child: BTextB4('جديد')));
}
