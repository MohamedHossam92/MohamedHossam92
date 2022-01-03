import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/state.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/state.dart';

class DownloadDeducts extends StatefulWidget {
  const DownloadDeducts({Key? key}) : super(key: key);

  @override
  State<DownloadDeducts> createState() => _DownloadDeductsState();
}

class _DownloadDeductsState extends State<DownloadDeducts> {
  int _timerValue = -1;
  bool _paused = true;
  bool done = false;

  final Stream<int> _periodicStream =
      Stream.periodic(const Duration(seconds: 2), (i) => i);
  int _previousStreamValue = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getDownloadDeductPrefs(),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = BlocProvider.of(context);
            return BlocConsumer<SQLTurnCubit, SQLTurnState>(
                listener: (context, state) {},
                builder: (context, state) {
                  SQLTurnCubit sqlTurnCubit = BlocProvider.of(context);
                  Size size = MediaQuery.of(context).size;
                  return BlocConsumer<SQLSlideCubit, SQLSlideState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        SQLSlideCubit sqlSlideCubit = BlocProvider.of(context);
                        return StreamBuilder(
                            stream: this._periodicStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data !=
                                    this._previousStreamValue) {
                                  this._previousStreamValue = snapshot.data!;
                                  if (!_paused) {
                                    this._timerValue++;
                                  }
                                  if (_timerValue == 5) {
                                    _paused = true;
                                    cubit.saveDownloadDeduct(true);
                                  }
                                }
                              }
                              return Column(
                                children: [
                                  SizedBox(
                                    height: size.height * .02,
                                  ),
                                  Card(
                                      color: Colors.yellow.shade200,
                                      child: DPadding(
                                          child: BTextB5(
                                              'شكراً لك ... هذه أهم وآخر خطوة'))),
                                  Wrap(
                                    children: List.generate(
                                      6,
                                      (i) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Card(
                                            elevation: i <= _timerValue ? 5 : 3,
                                            child: Image.asset(
                                              'assets/images/windows/systems/s00$i.png',
                                              width: size.width * .28,
                                            ),
                                          ),
                                          if (i <= _timerValue)
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.done_all,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Card(
                                                  color: Colors.green,
                                                  child: DPadding(
                                                    val: .01,
                                                    child: Column(
                                                      children: [
                                                        WTextB4('تم التحميل'),
                                                        WTextB4('علي هاتفك'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _paused && !cubit.downloadDeduct
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: size.height * .02,
                                            ),
                                            BTextB5(
                                                'سوف يتم تحميل التخصيمات علي هاتفك'),
                                            DPadding(
                                                child: BTextB4(
                                                    'وهذا سيساعدك مستقبلاً في تعديلها والإضافة إليها')),
                                            SizedBox(
                                              height: size.height * .02,
                                            ),
                                            DPadding(
                                                child: BTextB4(
                                                    'إضغط علي تحميل التخصيمات')),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/logo.png',
                                                  width: size.width * .15,
                                                ),
                                                MaterialButton(
                                                  child: DPadding(
                                                      child: BTextB5(
                                                          'تحميل التخصيمات ')),
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    sqlSlideCubit
                                                        .getDataFromDb();
                                                    sqlTurnCubit
                                                        .getDataFromDb();
                                                    sqlSlideCubit
                                                        .insertAllDeduct();
                                                    sqlTurnCubit
                                                        .insertAllDeduct();
                                                    setState(() =>
                                                        this._paused =
                                                            !this._paused);
                                                  },
                                                ),
                                                Image.asset(
                                                  'assets/images/logo.png',
                                                  width: size.width * .15,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : (!cubit.downloadDeduct
                                          ? Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/gif/robotintro_dribble.gif',
                                                  width: size.width * .5,
                                                ),
                                                if (_timerValue == -1)
                                                  BTextB5(
                                                      'جارِ تحميل التخصيمات علي هاتفك'),
                                                if (_timerValue == 0)
                                                  BTextB5(
                                                      'لا تغلق التطبيق قبل الانتهاء'),
                                                if (_timerValue == 1)
                                                  BTextB5(
                                                      'اقضي وقت الانتظار تسبيح واستغفار'),
                                                if (_timerValue == 2)
                                                  BTextB5(
                                                      'ستستطيع تعديل التخصيمات حسب شغلك'),
                                                if (_timerValue == 3)
                                                  BTextB5(
                                                      'ستتمكن أيضاً من إضافة تخصيماتك الخاصة'),
                                                if (_timerValue == 4)
                                                  BTextB5('شكراً لانتظارك'),
                                                if (_timerValue == 5)
                                                  BTextB5(
                                                      'تم الانتهاء ... شكراً لك'),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: size.height * .08,
                                                ),
                                                Card(
                                                  color: Colors.yellow,
                                                  child: DPadding(
                                                      child: BTextB5(
                                                          'تم تحميل التخصيمات ... شكراً لك')),
                                                ),
                                                BTextB4(
                                                    'اضغط علي الخطوة التالية')
                                              ],
                                            ))
                                ],
                              );
                            });
                      });
                });
          }),
    );
  }
}
