import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/user_options.dart';
import 'package:the_smart_workshop/screens/catalogue/home_content.dart';
import 'package:the_smart_workshop/screens/deducts/home_content.dart';
import 'package:the_smart_workshop/screens/utilities/home_content.dart';

import 'buttons.dart';

class HomeBody extends StatelessWidget {
  final List<Widget> userList = [Deducts(), Carpenter(), Customer()];
  final List<Widget> userUtilities = [
    Utilities(),
    CustomerUtilities(),
    CustomerUtilities()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          final List<Widget> isPressedList = [
            userList[cubit.getUserTypePrefs],
            userUtilities[cubit.getUserTypePrefs],
            Catalogue()
          ];

          Size size = MediaQuery.of(context).size;
          return Column(
            children: [
              Container(
                width: size.width * .9,
                height: size.height * .39,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                          spreadRadius: 0)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.height * .015),
                        topRight: Radius.circular(size.height * .015))),
                child: Column(
                  children: [
                    isPressedList[cubit.randomButton],
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
              Home3ButtonWidget(),
            ],
          );
        });
  }
}
