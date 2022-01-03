import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list/lower_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/unit_card.dart';

class LowerUnit extends StatelessWidget {
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
                        children: List.generate(lowerUnit.length, (i) {
                          return Container(
                            width: size.width * .32,
                            height: size.height * .2,
                            child: UnitCard(
                              isNew: lowerUnit[i].isNew,
                              unitId: lowerUnit[i].imageId.toString(),
                              unitName: lowerUnit[i].unitName,
                              onTap: () {
                                Navigator.pop(context);

                                addKitchenCubit.changeUnitData(
                                    lowerUnit[i].unitId,
                                    lowerUnit[i].unitName,
                                    lowerUnit[i].imageId);
                                componentCubit.priceValueChange(
                                    lowerUnit[i].rackLength,
                                    lowerUnit[i].isMultiWidth);

                                if (lowerUnit[i].isMultiWidth ||
                                    lowerUnit[i].isDrawer &&
                                        !lowerUnit[i].withoutShutter ||
                                    lowerUnit[i].isOpened ||
                                    lowerUnit[i].isFixed)
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                          child: DialogW(
                                              lowerUnit[i].imageId.toString(),
                                              lowerUnit[i]
                                                  .widthMultiShutterLength,
                                              i,
                                              lowerUnit)));
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

class DialogW extends StatelessWidget {
  final int i;
  final String imageId;
  final int widthShutterLength;
  final List list;

  DialogW(this.imageId, this.widthShutterLength, this.i, this.list);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddKitchenCubit, AddKitchenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Container(
              height: !list[i].withoutShutter && list[i].isDrawer ||
                      list[i].isOpened ||
                      list[i].isWithTilt ||
                      list[i].isFixed
                  ? (list[i].isMultiWidth
                      ? size.height * .55
                      : size.height * .2)
                  : size.height * .45,
              child: Column(
                children: [
                  if (list[i].isMultiWidth)
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image.asset(
                              'assets/images/kitchen_unit/$imageId.jpg',
                              width: size.width * .45,
                            ),
                            if (addKitchenCubit.isSize3_2 ||
                                addKitchenCubit.isSize2_2)
                              Positioned(
                                left: size.width * .2,
                                child: Container(
                                    color: Colors.green,
                                    child: WTextB5(
                                        '${addKitchenCubit.isSize3_2 ? '${widthShutterLength == 1 ? 'الثلثين' : 'الثلث'}' : 'النصف'}')),
                              ),
                            if (addKitchenCubit.isSize3_2 ||
                                addKitchenCubit.isSize2_2)
                              Container(
                                color: Colors.green,
                                child: WTextB5(
                                    '${addKitchenCubit.isSize3_2 ? '${widthShutterLength == 1 ? 'الثلث' : 'الثلثين'}' : 'النصف'}'),
                              ),
                          ],
                        ),
                        DPadding(
                          child: Container(
                              color: Colors.yellow,
                              child: DPadding(
                                child: BTextB5('تقسيط المسافة للدرف'),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChoiceChip(
                                padding: EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                selectedColor: Colors.green,
                                onSelected: (val) {
                                  addKitchenCubit.isSizeChanged(0, val);
                                },
                                label: addKitchenCubit.isSize3_2
                                    ? WTextB4('الثلث والثلثين')
                                    : BTextB4('الثلث والثلثين'),
                                selected: addKitchenCubit.isSize3_2),
                            ChoiceChip(
                                padding: EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                selectedColor: Colors.green,
                                onSelected: (val) {
                                  addKitchenCubit.isSizeChanged(1, val);
                                },
                                label: addKitchenCubit.isSize2_2
                                    ? WTextB4('النصف والنصف')
                                    : BTextB4('النصف والنصف'),
                                selected: addKitchenCubit.isSize2_2),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: cLogoColor,
                        ),
                      ],
                    ),
                  if (!list[i].withoutShutter && list[i].isDrawer ||
                      list[i].isOpened ||
                      list[i].isFixed ||
                      list[i].isWithTilt)
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (list[i].isOpened ||
                              list[i].isFixed ||
                              list[i].isWithTilt)
                            Column(children: [
                              DPadding(
                                child: BTextB5(
                                    'أدخل مقاس ${list[i].isOpened ? 'الجزء المفتوح' : list[i].isWithTilt ? 'الدرفة القلاب' : 'الثابت'}'),
                              ),
                              DTextField(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      suffix: Text('سم'),
                                      labelText:
                                          'أدخل مقاس ${list[i].isOpened ? 'الجزء المفتوح' : list[i].isWithTilt ? 'الدرفة القلاب' : 'الثابت'}'),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (val) {
                                    addKitchenCubit.isDrawerFixedOpenedChange(
                                        val: val,
                                        isOpen: list[i].isOpened,
                                        isFixed: list[i].isFixed,
                                        isTilt: list[i].isWithTilt);
                                  },
                                  validator: (String? val) {
                                    if (val!.isEmpty) return 'يجب إدخال قيمة';
                                  },
                                ),
                              ),
                            ]),
                          if (list[i].isDrawer && !list[i].withoutShutter)
                            Column(children: [
                              DPadding(
                                child: BTextB5('أدخل مقاس ارتفاع وش الدرج'),
                              ),
                              DTextField(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      suffix: Text('سم'),
                                      labelText: 'أدخل مقاس ارتفاع وش الدرج'),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.]')),
                                  ],
                                  onChanged: (val) {
                                    addKitchenCubit.isDrawerFixedOpenedChange(
                                        val: val, isDrawer: list[i].isDrawer);
                                  },
                                  validator: (String? val) {
                                    if (val!.isEmpty) return 'يجب إدخال قيمة';
                                  },
                                ),
                              ),
                            ]),
                        ],
                      ),
                    ),
                  MaterialButton(
                    child: WTextB5('حفظ وخروج'),
                    color: cLogoColor,
                    onPressed: () {
                      if (!list[i].isMultiWidth && list[i].isOpened ||
                          list[i].isWithTilt ||
                          list[i].isFixed ||
                          (list[i].isDrawer && !list[i].withoutShutter)) {
                        if (_formKey.currentState!.validate())
                          Navigator.pop(context);
                      }
                      if (list[i].isMultiWidth) {
                        if (addKitchenCubit.isSize3_2 ||
                            addKitchenCubit.isSize2_2) {
                          if (list[i].isOpened ||
                              list[i].isFixed ||
                              list[i].isDrawer) {
                            Navigator.pop(context);
                          } else
                            Navigator.pop(context);
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(
                              dSnackBarShowResult(
                                  title: 'من فضلك حدد تقسيط المسافة أولاً.',
                                  icon: Icons.error_rounded));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
