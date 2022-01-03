import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

class SureTechnical extends StatelessWidget {
  const SureTechnical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          return Column(
            children: [
              SizedBox(
                height: size.height * .02,
              ),
              Card(
                  color: Colors.yellow.shade200,
                  child: DPadding(
                      child: BTextB5('دعنا أولاً نتأكد أنك فني ألومنيوم ؟'))),
              SizedBox(
                height: size.height * .02,
              ),
              Wrap(
                children: List.generate(
                    6,
                    (i) => GestureDetector(
                          onTap: () {
                            cubit.sureTechnicalChange(i);
                          },
                          child: Card(
                            color: cubit.sureTechnical == i
                                ? Colors.yellow.shade200
                                : Colors.white,
                            elevation: 5,
                            child: Image.asset(
                              'assets/images/user_type/00$i.png',
                              width: size.width * .28,
                            ),
                          ),
                        )),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              BTextB5('أمامك مجموعة من القطاعات كلها للمطابخ '),
              DPadding(child: BTextB5(' ماعدا قطاع واحد ... اضغط عليه')),
              DPadding(child: BTextB4('ثم اضغط الخطوة التالية')),
              SizedBox(
                height: size.height * .01,
              ),
              Card(
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        DPadding(
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.yellow,
                          ),
                        ),
                        WTextB4('كن دقيقاً قبل إختيارك'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
