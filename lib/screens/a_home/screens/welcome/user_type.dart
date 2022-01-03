import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

class UserType extends StatelessWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;
          List<String> userName = [
            'فني ألومنيوم / U-PVC',
            'نجار مطابخ / دريسنج',
            'عميل مُتعاقد'
          ];

          List<String> userType = [
            'يستفيد بخدمات التطبيق كاملة .',
            'تستطيع اجراء التقارير للمطابخ الخشبية 18 مم .\n\n'
                'و مشاهدة كتالوجات الألوان والصور  للخامات .',
            'يمكنك الحصول علي استشارات فنية لأعمالك .\n\n'
                'و مشاهدة كتالوجات الألوان والصور  للخامات .'
          ];

          int index = cubit.userState.indexOf(true);
          return Column(
            children: List.generate(
                3,
                (i) => DPadding(
                      child: GestureDetector(
                        onTap: () {
                          cubit.userStateChange(i, true);
                          cubit.saveUserType(i);
                        },
                        child: Container(
                          width: size.width * .97,
                          height: size.height * .18,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/user_type/user_type00$i.jpg'),
                                  fit: BoxFit.cover),
                              boxShadow: cubit.userState[i] == true
                                  ? [
                                      BoxShadow(
                                          color: cLogoColor,
                                          blurRadius: 5,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0)
                                    ]
                                  : [],
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Checkbox(
                                    value: cubit.userState[i],
                                    onChanged: (val) {
                                      cubit.userStateChange(i, val);
                                    },
                                  )),
                              Positioned(
                                  bottom: 5,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white70,
                                    ),
                                    child:
                                        DPadding(child: BTextB5(userName[i])),
                                  )),
                              if (cubit.userState[i] == true)
                                Container(
                                    color: Colors.black45,
                                    child: DPadding(
                                        child: WTextB4(userType[index])))
                            ],
                          ),
                        ),
                      ),
                    )),
          );
        });
  }
}
