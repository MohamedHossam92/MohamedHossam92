import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/drawer/corner_drawer.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/corner_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';

class Corner extends StatelessWidget {
  static String id = 'CornerUnit';
  final bool isKitchenUnit;

  final _formKey = GlobalKey<FormState>();
  final _formKeyAngle = GlobalKey<FormState>();

  Corner([this.isKitchenUnit = false]);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CornerCubit, CornerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CornerCubit cornerCubit = BlocProvider.of(context);
          return BlocConsumer<AddKitchenCubit, AddKitchenState>(
              listener: (context, state) {},
              builder: (context, state) {
                AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
                String backCorner =
                    '${cornerCubit.backAngle > 90 ? 'مفتوحة' : 'مقفولة'}:';

                return WillPopScope(
                  onWillPop: () async {
                    cornerCubit.clearCornerAngle();
                    return true;
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                          '${isKitchenUnit ? 'تعديل تفاصيل الركنة' : 'تخصيم الركنة'}'),
                    ),
                    body: AppBackGround(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CornerDrawer(
                              backLeft: cornerCubit.backLeft,
                              backRight: cornerCubit.backRight,
                              deepLeft: cornerCubit.deepLeft,
                              deepRight: cornerCubit.deepRight,
                              height: cornerCubit.height,
                              backAngle: cornerCubit.backAngle,
                              cuttingFrontLeftAngle:
                                  cornerCubit.cornerList.isNotEmpty
                                      ? cornerCubit.cornerList[0]
                                          .cuttingFrontLeftAngle()
                                          .toStringAsFixed(1)
                                      : '',
                              cuttingFrontRightAngle:
                                  cornerCubit.cornerList.isNotEmpty
                                      ? cornerCubit.cornerList[0]
                                          .cuttingFrontRightAngle()
                                          .toStringAsFixed(1)
                                      : '',
                              cuttingBackAngle:
                                  cornerCubit.cornerList.isNotEmpty
                                      ? cornerCubit.cornerList[0]
                                          .cuttingBackAngle()
                                          .toStringAsFixed(1)
                                      : '',
                              frontSide: cornerCubit.cornerList.isNotEmpty
                                  ? cornerCubit.cornerList[0]
                                      .frontSide()
                                      .toStringAsFixed(1)
                                  : '',
                              is90: addKitchenCubit.is90,
                              columnLeft: 20,
                              columnRight: 40,
                              isWithColumn: true,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            !cornerCubit.showBackAngle
                                ? Form(
                                    key: _formKey,
                                    child: !cornerCubit.showResult
                                        ? Wrap(
                                            alignment: WrapAlignment.center,
                                            children: List.generate(
                                                isKitchenUnit ? 5 : 4, (i) {
                                              List<String> data = [
                                                'الضلع أ',
                                                'الضلع ب',
                                                'الضلع ج',
                                                'الضلع د',
                                                'ارتفاع الركنة'
                                              ];
                                              return SizedBox(
                                                height: size.height * .07,
                                                width: size.width * .48,
                                                child: DPadding(
                                                    child: TextFormField(
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        decoration:
                                                            InputDecoration(
                                                          suffix: Text('سم'),
                                                          labelText: data[i],
                                                        ),
                                                        onChanged:
                                                            (String? val) {
                                                          cornerCubit
                                                              .cornerSizesChange(
                                                                  i, val);
                                                        },
                                                        validator: (val) {
                                                          if (val!.isEmpty) {
                                                            return 'أدخل قيمة';
                                                          }
                                                        })),
                                              );
                                            }))
                                        : SizedBox())
                                : Column(
                                    children: [
                                      Form(
                                        key: _formKeyAngle,
                                        child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: List.generate(3, (i) {
                                              List<String> data = [
                                                'الضلع أ',
                                                ' الضلع ج',
                                                ' الوتر'
                                              ];
                                              return SizedBox(
                                                height: size.height * .07,
                                                width: size.width * .48,
                                                child: DPadding(
                                                  child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration:
                                                          InputDecoration(
                                                        suffix: Text('سم'),
                                                        labelText: data[i],
                                                      ),
                                                      onChanged: (String? val) {
                                                        cornerCubit
                                                            .cornerBackAngleChange(
                                                                i, val);
                                                      },
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return 'أدخل قيمة';
                                                        }
                                                      }),
                                                ),
                                              );
                                            })),
                                      ),
                                      MaterialButton(
                                          child: WTextB4('استخرج زاوية الحائط'),
                                          color: cLogoColorW,
                                          onPressed: () {
                                            cornerCubit.showAngleChanged();
                                            cornerCubit.clearLists();
                                            CornerAngleData c = CornerAngleData(
                                                side1st: cornerCubit.side1st,
                                                side2nd: cornerCubit.side2nd,
                                                water: cornerCubit.water);
                                            cornerCubit
                                                .addNewCornerBackAngle(c);
                                          }),
                                      MaterialButton(
                                          child: WTextB4('إلغاء'),
                                          color: Colors.black,
                                          onPressed: () {
                                            cornerCubit.showAngleChanged();
                                          }),
                                    ],
                                  ),
                            Divider(
                              thickness: 2,
                            ),
                            if (!cornerCubit.showBackAngle)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      BTextB5(
                                          '   زاوية الحائط ${cornerCubit.backAngle != 90 ? backCorner : 'قائمة  '}     '),
                                      Card(
                                          color: Colors.green.shade900,
                                          child: DPadding(
                                            child: WTextB8(
                                                '${cornerCubit.backAngle.toStringAsFixed(0)}^'),
                                          )),
                                    ],
                                  ),
                                  MaterialButton(
                                    child: BTextB5('تغيير زاوية الحائط'),
                                    color: Colors.yellow,
                                    onPressed: () {
                                      cornerCubit.showAngleChanged();
                                    },
                                  ),
                                ],
                              ),
                            Divider(
                              thickness: 2,
                            ),
                            if (!cornerCubit.showBackAngle)
                              MaterialButton(
                                  child: isKitchenUnit
                                      ? WTextB4('حفظ وخروج')
                                      : WTextB4(
                                          '${cornerCubit.showResult ? 'عملية جديدة' : 'أظهر النتائج'}'),
                                  color: cLogoColorW,
                                  onPressed: () {
                                    if (!cornerCubit.showResult &&
                                        _formKey.currentState!.validate()) {
                                      if (isKitchenUnit) {
                                        Navigator.pop(context);
                                      } else {
                                        CornerData c = CornerData(
                                            width: cornerCubit.backLeft,
                                            height: cornerCubit.backRight,
                                            deepLeft: cornerCubit.deepLeft,
                                            deepRight: cornerCubit.deepRight,
                                            cornerHeight: cornerCubit.height,
                                            backAngle: cornerCubit.backAngle,
                                            unitType: 1,
                                            rackLength: 1,
                                            unitName: '',
                                            id: 1,
                                            imageId: 4001,
                                            unitId: 10,
                                            shutterLength: 1,
                                            shutterDoubleFillDeduct: 7.3);
                                        cornerCubit.addNewCorner(c);
                                        cornerCubit.showResultChanged();
                                      }
                                      _formKey.currentState!.reset();
                                    } else {
                                      cornerCubit.clearLists();
                                    }
                                    PrayPlay.playPray();
                                  }),
                            if (!isKitchenUnit)
                              MaterialButton(
                                  child: WTextB4('خروج'),
                                  color: Colors.black,
                                  onPressed: () {
                                    cornerCubit.clearCornerAngle();
                                    cornerCubit.clearLists();
                                    Navigator.pop(context);
                                    PrayPlay.playPray();
                                  }),
                            Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

class PositionedData {
  final String title;
  final double left, bottom;

  PositionedData(this.title, this.left, this.bottom);
}
