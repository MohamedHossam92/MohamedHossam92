import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/a_home.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginIPhone extends StatefulWidget {
  const LoginIPhone({Key? key}) : super(key: key);

  @override
  _LoginIPhoneState createState() => _LoginIPhoneState();
}

class _LoginIPhoneState extends State<LoginIPhone> {
  String phone = '', name = '';
  int password = 0, password2 = 0, code = -1;
  bool isNewMember = false, showPassword = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (isNewMember)
                          SPadding(
                            v: .02,
                            h: .04,
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) return 'يجب إدخال قيمة';
                              },
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person_pin_rounded),
                                  iconColor: cLogoColor,
                                  hintText: 'الاسم التجاري'),
                              onChanged: (val) {
                                name = val;
                                this.setState(() {});
                              },
                            ),
                          ),
                        SPadding(
                          v: .02,
                          h: .04,
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) return 'يجب إدخال قيمة';
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone_android),
                                iconColor: cLogoColor,
                                hintText: 'رقم الهاتف'),
                            onChanged: (val) {
                              phone = val;
                              this.setState(() {});
                            },
                          ),
                        ),
                        SPadding(
                          v: .02,
                          h: .04,
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) return 'يجب إدخال قيمة';
                              if (val.length != 6)
                                return 'يجب أن تكون 6 أرقام .';
                            },
                            obscureText: showPassword,
                            decoration: InputDecoration(
                                icon: Icon(Icons.remove_red_eye),
                                iconColor: cLogoColor,
                                hintText: 'كلمة المرور',
                                suffix: GestureDetector(
                                  child: Text(
                                    !showPassword ? 'إخفاء' : 'إظهار',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    showPassword = !showPassword;
                                    this.setState(() {});
                                  },
                                )),
                            onChanged: (val) {
                              password = int.parse(val);
                              this.setState(() {});
                            },
                          ),
                        ),
                        if (isNewMember)
                          SPadding(
                            v: .02,
                            h: .04,
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) return 'يجب إدخال قيمة';
                                if (password2 != password)
                                  return 'كلمة المرور غير متطابقة';
                              },
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                icon: Icon(Icons.remove_red_eye),
                                iconColor: cLogoColor,
                                hintText: 'تأكيد كلمة المرور',
                              ),
                              onChanged: (val) {
                                password2 = int.parse(val);
                                this.setState(() {});
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  MaterialButton(
                      color: cLogoColor,
                      child: WTextB5('تسجيل ${isNewMember ? '' : 'دخول'}'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (isNewMember) {
                            await launch(whatsApp(
                                phone: '01020608160',
                                message: 'طلب تسجيل عضوية جديدة\n'
                                    'وبياناتي كالآتي:-\n'
                                    'الاسم التجاري : $name \n'
                                    'رقم الهاتف $phone \n'
                                    'وشكراً لكم'));
                          } else {
                            int phoneString =
                            int.parse(phone.substring(3, phone.length));
                            String data = ((phoneString / 92).round())
                                .toString()
                                .substring(0, 6);

                            code = int.parse(data);
                            this.setState(() {});
                            print(cubit.isLoginIOS);

                            if (password == code) {

                              await cubit.saveUserType(cubit.userType);
                              await cubit.saveEnterApp(true);
                              PrayPlay.playPray();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));

                              cubit.loginIOSChange();
                              print(cubit.isLoginIOS);
                            }
                          }
                        }
                      }),
                  if (!isNewMember)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BTextB5('أو      '),
                        Icon(Icons.account_box),
                        TextButton(
                            onPressed: () {
                              isNewMember = true;
                              this.setState(() {});
                            },
                            child: Text('تسجيل عضوية جديدة')),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
