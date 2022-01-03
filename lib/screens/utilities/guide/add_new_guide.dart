import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us_button.dart';

class AddNewGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);
          Size size = MediaQuery.of(context).size;
          return Container(
              height: size.height * .42,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        color: cLogoColor,
                      ),
                      child: DPadding(
                        val: .05,
                        child:
                            Center(child: WTextB5('إضافة نفسك في دليل التجار')),
                      ),
                    ),
                    DPadding(
                        child: Form(
                            child: Column(
                                children: List.generate(4, (i) {
                      List<String> dataList = [
                        'الإسم التجاري',
                        'نوع النشاط',
                        'العنوان',
                        'رقم الهاتف',
                      ];
                      List<IconData> icon = [
                        Icons.perm_contact_cal_rounded,
                        Icons.add_business_sharp,
                        Icons.edit_location,
                        Icons.phone_android
                      ];
                      return DTextField(
                          child: TextFormField(
                        decoration: InputDecoration(
                            labelText: dataList[i], icon: Icon(icon[i])),
                        onChanged: (val) {
                          homeCubit.guideData(i, val);
                        },
                      ));
                    })))),
                    CallUsButton('السلام عليكم ورحمة الله وبركاته \n ' +
                        'ارغب في إضافة متجري إلي دليل التجار وبياناتي هي :- \n ' +
                        '${homeCubit.guideName} \n${homeCubit.guideType} \n${homeCubit.guidePhone} \n${homeCubit.guidePlace} ' +
                        '\n فما هي الخطوات المطلوبة')
                  ],
                ),
              ));
        });
  }
}
