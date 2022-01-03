import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

var formKey = GlobalKey<FormState>();

class AddSize extends StatelessWidget {
  final bool isKitchen;

  const AddSize({this.isKitchen = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit cubit = BlocProvider.of(context);
          return Form(
            key: formKey,
            child: Container(
              color: Colors.white70,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                        children: List.generate(isKitchen ? 3 : 2, (i) {
                      List<String> dataList = ['العرض', 'الإرتفاع', 'العمق'];
                      return Expanded(
                        child: DTextField(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: dataList[i],
                              suffix: Text('سم'),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]')),
                            ],
                            onChanged: (String val) {
                              cubit.sizeChange(i, val);
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'يجب إدخال قيمة';
                              }
                            },
                          ),
                        ),
                      );
                    })),
                  ),
                  if (!isKitchen)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () {
                              cubit.incrementWindowsList();
                            }),
                        BTextB5(cubit.length.toString()),
                        IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              cubit.decrementWindowsList(1);
                            }),
                      ],
                    )
                ],
              ),
            ),
          );
        });
  }
}
