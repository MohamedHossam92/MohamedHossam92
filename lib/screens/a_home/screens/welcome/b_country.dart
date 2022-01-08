import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

const List<String> country = ['جمهورية مصر العربية', 'دولة عربية شقيقة'];
const List<String> countryFlag = ['egypt.png', 'other_country.jpg'];

class Country extends StatelessWidget {
  const Country({Key? key}) : super(key: key);

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
              BTextB5('الدولة التي ترغب بتحميل البيانات الخاصة بها'),
              SizedBox(
                height: size.height * .04,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    2,
                    (i) => Flexible(
                      child: GestureDetector(
                        onTap: () {
                          cubit.countryGroupValChange(i);
                          if (i == 1) {
                            cubit.userStateChange(0, true);
                            cubit.saveUserType(0);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: cubit.countryGroupVal == i
                                  ? [
                                      BoxShadow(
                                          color: cLogoColor,
                                          blurRadius: 5,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0)
                                    ]
                                  : [],
                              borderRadius: BorderRadius.circular(15)),
                          child: DPadding(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/user_type/${countryFlag[i]}',
                                  width: size.width * .3,
                                ),
                                Radio(
                                    value: i,
                                    groupValue: cubit.countryGroupVal,
                                    onChanged: (val) {
                                      cubit.countryGroupValChange(val);
                                      if (i == 1) {
                                        cubit.userStateChange(0, true);
                                        cubit.saveUserType(0);
                                      }
                                    }),
                                BTextB4(country[i]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: size.height * .06,
              ),
              Card(
                color: Colors.white70,
                child: DPadding(
                  child: Column(
                    children: [
                      BTextB4('قريباً بإذن الله سيتم اضافة بعض الدول الأخري'),
                      SizedBox(
                        height: 5,
                      ),
                      BTextB4('فنتمني منك مساعدتنا'),
                      SizedBox(
                        height: 5,
                      ),
                      BTextB4('بالتواصل معنا من داخل التطبيق'),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
