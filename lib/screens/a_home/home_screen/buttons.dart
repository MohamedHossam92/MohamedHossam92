import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

class Home3Button {
  final String title;
  final bool leftRadius;
  final bool rightRadius;
  final int i;
  final Function isPressed;

  Home3Button(
      {required this.title,
      this.leftRadius = false,
      this.rightRadius = false,
      required this.i,
      required this.isPressed});
}

class Home3ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> userType = ['تخصيمات', 'مطابـخ', 'استشارة'];

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);

          List<Home3Button> home3ButtonList = [
            Home3Button(
                i: 0,
                title: userType[cubit.getUserTypePrefs],
                rightRadius: true,
                isPressed: () {}),
            Home3Button(i: 1, title: 'خدمات', isPressed: () {}),
            Home3Button(
                i: 2, title: 'كتالوجات', leftRadius: true, isPressed: () {})
          ];
          return Container(
            width: size.width * .9,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: home3ButtonList.map((e) {
                  return Container(
                    height: size.height * .06,
                    width: size.width * .295,
                    decoration: BoxDecoration(
                        boxShadow: e.i == cubit.randomButton
                            ? [
                                BoxShadow(
                                    color: cLogoColor,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                    spreadRadius: 0)
                              ]
                            : [],
                        gradient: e.i == cubit.randomButton
                            ? cLogoGradient
                            : cWhiteGradient,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )),
                    child: Center(
                      child: MaterialButton(
                        child: e.i == cubit.randomButton
                            ? WTextB5(e.title)
                            : WTextB5(e.title),
                        onPressed: () {
                          cubit.isPressedChanged(home3ButtonList.indexOf(e));
                        },
                      ),
                    ),
                  );
                }).toList()),
          );
        });
  }
}
