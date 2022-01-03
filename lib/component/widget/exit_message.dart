import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

class DOnWillPop extends StatelessWidget {
  final Widget child;
  final Function toExit;

  const DOnWillPop({required this.toExit, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;
          return WillPopScope(
              onWillPop: () async {
                final shw = await showDialog(
                    context: context,
                    builder: (context) => Dialog(
                        backgroundColor: Colors.black54,
                        child: Card(
                          color: Colors.black54,
                          child: Container(
                            color: Colors.transparent,
                            height: size.height * .25,
                            child: Scaffold(
                              body: Column(
                                children: [
                                  Icon(
                                    Icons.warning_rounded,
                                    size: size.width * .17,
                                    color: cLogoColorW,
                                  ),
                                  DPadding(
                                    child: BTextB4(
                                        'قد تفقد كل البيانات التي قمت بإدخالها'),
                                  ),
                                  DPadding(
                                      child:
                                          BTextB5('فهل أنت متأكد من الخروج ؟')),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                          color: Colors.black54,
                                          child: WTextB4('خروج علي أي حال'),
                                          onPressed: () {
                                            toExit();
                                            cubit.playPray();
                                          }),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      MaterialButton(
                                          color: cLogoColorW,
                                          child: WTextB4('انتظر'),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )));
                return shw ?? false;
              },
              child: child);
        });
  }
}
