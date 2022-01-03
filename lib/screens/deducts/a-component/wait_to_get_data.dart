import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';

class StreamBuilderExample extends StatefulWidget {
  final int index;

  const StreamBuilderExample(this.index, {Key? key}) : super(key: key);
  @override
  StreamBuilderExampleState createState() => StreamBuilderExampleState();
}

class StreamBuilderExampleState extends State<StreamBuilderExample> {
  int _timerValue = 0, _timeToClose = 0;
  bool _paused = false, _pausedToClose = false;

  final Stream<int> _periodicStream =
      Stream.periodic(const Duration(milliseconds: 350), (i) => i);

  int _previousStreamValue = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .35,
      color: Colors.transparent,
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      child: AppBackGround(
        child: StreamBuilder(
          stream: this._periodicStream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != this._previousStreamValue) {
                this._previousStreamValue = snapshot.data!;
                if (!_paused) {
                  this._timerValue++;
                }
                if (!_pausedToClose) {
                  this._timeToClose++;
                }

                if (_timerValue == 23) _paused = true;
                if (_timeToClose == 30) _pausedToClose = true;

                if (_timeToClose == 30) Navigator.pop(context);
              }
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/gif/robotintro_dribble.gif',
                  width: size.width * .6,
                ),
                Card(
                    color: Colors.yellow.shade200,
                    child: DPadding(
                        child:
                            BTextB5('جارِ اعداد التقارير ... انتظر قليلاً'))),
                if (_timerValue <= 23)
                  BTextB4(message()[widget.index][_timerValue]),
                if (_timeToClose > 23)
                  BTextB4('جاري الانهاء .. شكراً لانتظارك'),
              ],
            );
          },
        ),
      ),
    );
  }

  List<List<String>> message() => [windowsMessage, kitchenMessage];

  List<String> windowsMessage = [
    'جار استدعاء التخصيمات',
    'عملية التخصيم جارية',
    'جار تجهيز تقرير التجميع',
    'جار تجهيز تجميع الدرف',
    'جار تجهيزتجميع الحلق',
    'جار تجهيزتجميع السلك',
    'جار تجهيز تقرير التقطيع',
    'جار تجهيز تقطيع الدرف',
    'جار تجهيز تقطيع الحلق',
    'جار تجهيزتقطيع السلك',
    'جار تجهيز تقطيع المكملات',
    'جار تجهيز تقرير الزجاج',
    'جار تجهيز تقرير الاكسسوار',
    'جار تجهيز زوايا التجميع',
    'جار تجهيز السكاكات',
    'جار تجهيز العجل',
    'جار تجهيز المفصلات',
    'جار تجهيز الكاوتش',
    'جار تجهيز كاوتش الحلق',
    'جار تجهيز كاوتش البار',
    'جار تجهيز كاوتش الزجاج',
    'جار تجهيز كاوتش مركزي',
    'جار تجهيز جاري الانهاء',
    'جاري الانهاء من التقارير',
    'جاري الانهاء من التقارير وفتح النتائج',
  ];

  List<String> kitchenMessage = [
    'جار استدعاء التخصيمات',
    'عملية التخصيم جارية',
    'جار تجهيز تقرير التجميع',
    'جار تجهيز تجميع الدرف',
    'جار تجهيز تجميع الأرفف',
    'جار تجهيزتجميع القواطع',
    'جار تجهيز تقرير الحشو',
    'جار تجهيز تقطيع الظهريات',
    'جار تجهيز تقطيع الأجناب والأرضيات',
    'جار تجهيز تقطيع الأدراج',
    'جار تجهيز تقطيع الزجاج',
    'جار تجهيز تقرير الدرف',
    'جار تجهيز تقرير الاكسسوار',
    'جار تجهيز زوايا المقابض',
    'جار تجهيز المفصلات',
    'جار تجهيز المجر',
    'جار تجهيز الأرجل',
    'جار تجهيز حساب الخامات',
    'جار تجهيز حساب الأكسسوارات',
    'جار تجهيز حساب الألوح',
    'جار تجهيز حساب الأعود',
    'جار تجهيز الوحدات',
    'جار تجهيز جاري الانهاء',
    'جاري الانهاء من التقارير',
    'جاري الانهاء من التقارير وفتح النتائج',
  ];
}

showWaiting(context, i) => Container(
    child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StreamBuilderExample(i)));
