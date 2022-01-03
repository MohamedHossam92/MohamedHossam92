import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list/cupboard_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/unit_card.dart';

class CupboardUnit extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;

          ComponentCubit componentCubit = BlocProvider.of(context);
          return BlocConsumer<AddKitchenCubit, AddKitchenState>(
              listener: (context, state) {},
              builder: (context, state) {
                AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(cupboardUnit.length, (i) {
                          return Container(
                            width: size.width * .32,
                            height: size.height * .33,
                            child: UnitCard(
                              height: .28,
                              isNew: cupboardUnit[i].isNew,
                              unitId: cupboardUnit[i].imageId.toString(),
                              unitName: cupboardUnit[i].unitName,
                              onTap: () {
                                Navigator.pop(context);

                                addKitchenCubit.changeUnitData(
                                  cupboardUnit[i].unitId,
                                  cupboardUnit[i].unitName,
                                  cupboardUnit[i].imageId,
                                );
                                componentCubit.priceValueChange(
                                    cupboardUnit[i].rackLength,
                                    cupboardUnit[i].isMultiWidth);

                                if (cupboardUnit[i].isOpened)
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                              child: Container(
                                            height: size.height * .35,
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  DPadding(
                                                    child: BTextB5(
                                                        'أدخل مقاس فاتحة الفرن'),
                                                  ),
                                                  DTextField(
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          suffix: Text('سم'),
                                                          labelText:
                                                              'أدخل مقاس فاتحة الفرن'),
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      onChanged: (val) {
                                                        addKitchenCubit
                                                            .isDrawerFixedOpenedChange(
                                                                val: val,
                                                                isOpen:
                                                                    cupboardUnit[
                                                                            i]
                                                                        .isOpened);
                                                      },
                                                      validator: (String? val) {
                                                        if (val!.isEmpty)
                                                          return 'يجب إدخال قيمة';
                                                      },
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    child: WTextB5('حفظ وخروج'),
                                                    color: cLogoColor,
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate())
                                                        Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          )));
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
