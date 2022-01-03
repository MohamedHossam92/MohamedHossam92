import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/const/titles.dart';
import 'package:the_smart_workshop/component/widget/rate_us.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us.dart';
import 'package:the_smart_workshop/screens/utilities/design_kitchen/design_kitchen.dart';
import 'package:the_smart_workshop/screens/utilities/fly_screen/fly_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DCarouselSlider extends StatelessWidget {
  const DCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: DPadding(
            child: Card(
              color: Colors.black,
              child:
                  Center(child: DPadding(child: WTextB5('عروض الورشة الذكية'))),
            ),
          ),
        ),
        Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: List.generate(6, (i) {
              List<Color> color = [
                Colors.redAccent,
                Colors.purple,
                Colors.deepOrange,
                Colors.indigoAccent,
                Colors.green,
                Colors.black
              ];
              List onTap = [
                FlyScreen(),
                DesignKitchen(),
                FlyScreen(false),
                FlyScreen(),
                FlyScreen(),
                CallUs(),
              ];

              return DPadding(
                val: .01,
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: color[i],
                              blurRadius: 3,
                              offset: Offset(0, 2),
                              spreadRadius: 0)
                        ],
                        color: color[i],
                        borderRadius: BorderRadius.circular(size.width * .01)),
                    // height: size.height * .2,
                    // width: size.width * .4,
                    child: GestureDetector(
                      onTap: () async {
                        if (i == 3) {
                          await launch(whatsApp(
                              phone: '01094538013',
                              message:
                                  'السلام عليكم ورحمة الله وبركاته \n كنت حابب استفسر عن الخامة والأسعار ؟ وشكراً لكم ...'));
                        } else if (i == 4) {
                          await launch(whatsApp(phone: '01120972004'));
                        } else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => onTap[i]));
                      },
                      child: Card(
                        margin: EdgeInsets.all(1),
                        child: DPadding(
                          val: .005,
                          child: Image.asset(
                            'assets/images/new/00$i.png',
                            width: size.width * .28,
                          ),
                        ),
                      ),
                    )),
              );
            }))
      ],
    );
  }
}

//
// class DCarouselSlider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           HomeCubit homeCubit = BlocProvider.of(context);
//           Size size = MediaQuery.of(context).size;
//           return Column(
//             children: [
//               SizedBox(
//                 height: size.height * .015,
//               ),
//               Container(
//                 height: size.height * .18,
//                 child: CarouselSlider(
//                     options: CarouselOptions(
//                       disableCenter: false,
//                       height: size.height * .2,
//                       initialPage: homeCubit.randomSlider,
//                       autoPlay: true,
//                       autoPlayInterval: Duration(seconds: 7),
//                       autoPlayAnimationDuration: Duration(milliseconds: 800),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enlargeCenterPage: true,
//                       onPageChanged: (i, change) {
//                         homeCubit.isCarouselSliderChanged(i);
//                       },
//                     ),
//                     items: advList(context)),
//               ),
//               SlideChange(homeCubit, size)
//             ],
//           );
//         });
//   }
// }
//
// //===============================================================================
// class SlideChange extends StatelessWidget {
//   final homeCubit, size;
//
//   const SlideChange(this.homeCubit, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(4, (i) {
//         return DPadding(
//           val: .008,
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 800),
//             curve: Curves.easeInOutBack,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(size.width * .07),
//               color: i == homeCubit.randomSlider
//                   ? cLogoColorW
//                   : Colors.grey.shade300,
//             ),
//             width: i == homeCubit.randomSlider
//                 ? size.width * .07
//                 : size.width * .02,
//             height: size.width * .02,
//           ),
//         );
//       }),
//     );
//   }
// }
//
// //===============================================================================
//
// advList(context) {
//   Size size = MediaQuery.of(context).size;
//   List<Color> color = [
//     Colors.brown,
//     Colors.orange,
//     Colors.indigo,
//     Colors.blueGrey,
//   ];
//   List onTap = [DesignKitchen(), FlyScreen(), '01096660866', '01113703217'];
//
//   return List.generate(4, (i) {
//     return GestureDetector(
//       onTap: () async {
//         if (i < 2)
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => onTap[i]));
//         if (i > 1) {
//           final link = WhatsAppUnilink(
//             phoneNumber: '002-${onTap[i]}',
//             text: '$sWTal',
//           );
//
//           await launch('$link');
//         }
//       },
//       child:
//       DPadding(
//         child: Container(
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: color[i],
//                       blurRadius: 3,
//                       offset: Offset(0, 2),
//                       spreadRadius: 0)
//                 ],
//                 color: color[i],
//                 borderRadius: BorderRadius.circular(size.width * .01)),
//             height: size.height * .2,
//             width: size.width,
//             child: Card(
//               margin: EdgeInsets.all(1),
//               child: Image.asset('assets/images/new/00$i.png'),
//             )),
//       ),
//     );
//   });
// }
//
newAdvList(context) {
  Size size = MediaQuery.of(context).size;
  List<Color> color = [
    Colors.brown,
    Colors.orange,
    Colors.indigo,
    Colors.blueGrey,
  ];
  List<Widget> onTap = [CallUs(), RateUs(), RateUs(), CallUs()];

  return List.generate(4, (i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onTap[i]));
      },
      child: DPadding(
        child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: color[i],
                      blurRadius: 3,
                      offset: Offset(0, 2),
                      spreadRadius: 0)
                ],
                color: color[i],
                borderRadius: BorderRadius.circular(size.width * .01)),
            height: size.height * .2,
            width: size.width,
            child: Card(
              margin: EdgeInsets.all(1),
              child: Image.asset('assets/images/ads/00$i.png'),
            )),
      ),
    );
  });
}
