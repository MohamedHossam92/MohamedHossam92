// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:the_smart_workshop/component/const/colors.dart';
// import 'package:the_smart_workshop/component/const/texts.dart';
// import 'package:the_smart_workshop/component/widget/snack_bar.dart';
// import 'package:the_smart_workshop/screens/deducts/a-component/turn_cubit/turn_cubit.dart';
// import 'package:the_smart_workshop/screens/deducts/a-component/turn_cubit/state.dart';
//
// class KeyBoard extends StatelessWidget {
//   final Function() valChange;
//   final String data;
//
//   const KeyBoard(this.valChange, this.data);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => ComponentCubit()..keyboardResultChange(data),
//         child: BlocConsumer<ComponentCubit, ComponentState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               ComponentCubit componentCubit = BlocProvider.of(context);
//               String finalResult = componentCubit.keyboardResult;
//               Size size = MediaQuery.of(context).size;
//
//               btnStyle(String btnText, [Function? onTap]) => GestureDetector(
//                     onTap: () {
//                       if (finalResult.length >= 6) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             dSnackBarShowResult(
//                                 icon: Icons.error,
//                                 title: 'لقد تجاوزت الحد المسموح .'));
//                       } else {
//                         if (componentCubit.keyboardTab == -1) {
//                           componentCubit.keyboardResultChange('', 1);
//                         }
//                         componentCubit.incrementKeyboardTab();
//
//                         if (btnText != '.' &&
//                             btnText != '0' &&
//                             btnText != 'تم') {
//                           componentCubit.keyboardResultChange(btnText);
//                         } else {
//                           onTap!();
//                         }
//                       }
//                     },
//                     child: Card(
//                       margin: EdgeInsets.all(2),
//                       color: btnText == 'تم' ? cLogoColorW : Colors.black54,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(13)),
//                       child: Container(
//                           width: size.width * .23,
//                           height: size.height * .06,
//                           color: Colors.transparent,
//                           child: Center(child: WTextB8(btnText))),
//                     ),
//                   );
//
//               return Container(
//                 color: Colors.transparent,
//                 height: size.height * .275,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Container(
//                             width: size.width * .42,
//                             height: size.height * .07,
//                             child:
//                                 Center(child: BTextB8('$finalResult     سم'))),
//                         GestureDetector(
//                           onTap: () {
//                             componentCubit.keyboardResultChange('', 1);
//                           },
//                           child: Row(children: [
//                             Icon(
//                               Icons.clear,
//                             ),
//                             Text('مسح')
//                           ]),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       child: Wrap(children: [
//                         btnStyle('.', () {
//                           if (finalResult == '')
//                             componentCubit.keyboardResultChange('0');
//                           if (!finalResult.contains('.'))
//                             componentCubit.keyboardResultChange('.');
//                         }),
//                         btnStyle('3'),
//                         btnStyle('2'),
//                         btnStyle('1'),
//                         btnStyle('0', () {
//                           if (finalResult.length != 0)
//                             componentCubit.keyboardResultChange('0');
//                         }),
//                         btnStyle('6'),
//                         btnStyle('5'),
//                         btnStyle('4'),
//                         btnStyle('تم', () {
//                           Navigator.pop(context);
//                           componentCubit.keyboardToDouble();
//                           componentCubit.sizeChange(
//                               1, componentCubit.keyboardDouble);
//
//                           // valChange;
//                           print(componentCubit.height);
//                         }),
//                         btnStyle('9'),
//                         btnStyle('8'),
//                         btnStyle('7'),
//                       ]),
//                     ),
//                   ],
//                 ),
//               );
//             }));
//   }
// }
