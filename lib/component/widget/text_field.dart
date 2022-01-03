import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/text_scale.dart';

class DTextField extends StatelessWidget {
  final Widget child;

  DTextField({required this.child});

  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        DPadding(
          val: .012,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * .05, child: child),
        ));
  }
}

class DTextFieldMax extends StatelessWidget {
  final Function(String?) onChanged;
  final String labelText;
  late final Function validator;

  DTextFieldMax(
      {required this.onChanged,
      required this.labelText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        DPadding(
          val: .012,
          child: TextFormField(
            minLines: 1,
            maxLines: 6,
            maxLength: 200,
            key: key,
            validator: validator(),
            decoration: InputDecoration(labelText: (labelText)),
            onChanged: onChanged,
          ),
        ));
  }
}
