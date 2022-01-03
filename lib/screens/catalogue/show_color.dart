import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/share_message.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

import 'colors_list.dart';

class ShowColor extends StatelessWidget {
  final int i;
  final String code;

  ShowColor(this.i, this.code);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;

          dynamic color = homeCubit.selectedColor != null
              ? colorsData[homeCubit.selectedColor]
              : colorsData[code];

          return WillPopScope(
              onWillPop: () async {
                homeCubit.selectedColorChange();
                return true;
              },
              child: SafeArea(
                  child: Scaffold(
                      key: _scaffoldKey,
                      body: Column(
                        children: [
                          if (i == 0)
                            Container(
                              decoration: BoxDecoration(
                                  color: colorsData[code],
                                  border: Border.all(
                                    width: size.height * .02,
                                    color: color,
                                  )),
                              height: size.height * .81,
                              width: size.width,
                            ),
                          if (i > 0)
                            Container(
                              height: size.height * .81,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/catalogues/colors_catalogues/$code.jpg',
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                          MaterialButton(
                              color: Colors.blueGrey.shade800,
                              child: WTextB5('ارسل اللون للعميل علي الواتس'),
                              onPressed: () {
                                _scaffoldKey.currentState!.showBottomSheet(
                                    (context) => Container(
                                        height: size.height * .3,
                                        child: ShareMessage(code)));
                              }),
                          Card(
                              color: Colors.white70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DPadding(
                                    val: .04,
                                    child: BTextB4('كود اللون : $code'),
                                  ),
                                  if (i == 0)
                                    DropdownButton(
                                      hint: BTextB4('حدد لون الدرفة'),
                                      items: colorsData.keys.toList().map((e) {
                                        return DropdownMenuItem(
                                          child: Row(
                                            children: [
                                              DPadding(
                                                val: .01,
                                                child: CircleAvatar(
                                                  radius: size.height * .015,
                                                  backgroundColor:
                                                      colorsData[e],
                                                ),
                                              ),
                                              BTextB4(e)
                                            ],
                                          ),
                                          value: e,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        homeCubit.selectedColorChanged(val);
                                      },
                                      value: homeCubit.selectedColor,
                                    ),
                                ],
                              ))
                        ],
                      ))));
        });
  }
}
