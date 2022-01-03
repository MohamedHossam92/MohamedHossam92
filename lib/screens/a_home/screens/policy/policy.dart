import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

import 'list_of_data.dart';

class Policy extends StatelessWidget {
  static String id = 'Policy';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);

          return SafeArea(
            bottom: true,
            left: true,
            top: true,
            right: true,
            child: Scaffold(
              appBar: AppBar(
                title: Text('سياسة الخصوصية'),
              ),
              body: Container(
                color: Colors.grey.shade300,
                height: MediaQuery.of(context).size.height * .95,
                child: SingleChildScrollView(
                  child: DPadding(
                    child: Card(
                        child: ExpansionPanelList(
                            expandedHeaderPadding: EdgeInsets.all(0),
                            dividerColor: cLogoColor,
                            elevation: 4,
                            animationDuration: Duration(milliseconds: 700),
                            expansionCallback: (i, isOpen) {
                              homeCubit.expansionIndexChanged(i);
                            },
                            children: policy.map((e) {
                              return ExpansionPanel(
                                  isExpanded: homeCubit.expansionIndex ==
                                      policy.indexOf(e),
                                  backgroundColor: Colors.white,
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isOpen) {
                                    return ListTile(
                                        leading: Icon(
                                          e.icon,
                                          color: e.color,
                                        ),
                                        title: BTextB4(e.title));
                                  },
                                  body: Container(
                                    color: Colors.white,
                                    child: DPadding(
                                      child: BText4(e.content),
                                    ),
                                  ));
                            }).toList())),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
