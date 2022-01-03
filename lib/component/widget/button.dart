import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/texts.dart';

class SaveAndCloseButton extends StatelessWidget {
  const SaveAndCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.all(1),
        splashColor: Colors.yellow,
        color: cLogoColorW,
        onPressed: () {
          Navigator.pop(context);
        },
        child: WTextB4('حفظ'));
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Row(
          children: [Icon(Icons.threesixty_rounded), WTextB4('رجوع')],
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}
