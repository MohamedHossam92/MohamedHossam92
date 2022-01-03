import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUsButton extends StatelessWidget {
  final String message;

  const CallUsButton(this.message);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = BlocProvider.of(context);

          return !homeCubit.sendMessage
              ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  MaterialButton(
                    child: Text(
                      'إرســال',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      homeCubit.playPray();
                      final link =
                          whatsApp(phone: '01020608160', message: message);
                      await launch('$link');
                      homeCubit.sendMessageChanged();
                    },
                    color: cLogoColor,
                  ),
                  DPadding(
                    child: Image.asset('assets/images/social_icons/whats.png'),
                  ),
                ])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.width * .1,
                    ),
                    BTextB4(
                        'تم الإرسال بنجاح...\nانتظر الرد على تطبيق الواتس.'),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        homeCubit.sendMessageChanged();
                      },
                      child: Text(
                        'خروج',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                );
        });
  }
}
