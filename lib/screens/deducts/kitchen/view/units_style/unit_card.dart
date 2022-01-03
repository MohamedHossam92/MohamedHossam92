import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/new_card.dart';

class UnitCard extends StatelessWidget {
  final String unitId, unitName;
  final Function() onTap;
  final double height;
  final bool isNew;

  const UnitCard(
      {required this.unitId,
      required this.unitName,
      required this.onTap,
      this.isNew = false,
      this.height = .14});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: cLogoColor),
              borderRadius: BorderRadius.circular(
                size.width * .04,
              )),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 10,
                child: Container(
                  height: size.height * height,
                  child: Image.asset('assets/images/kitchen_unit/$unitId.jpg'),
                ),
              ),
              Positioned(
                bottom: 1,
                child: Container(
                    width: size.width * .25,
                    height: size.height * .027,
                    decoration: BoxDecoration(gradient: cLogoGradient),
                    child: Center(child: WTextB4(unitName))),
              ),
              if (isNew) Positioned(top: 1, left: 8, child: newCard()),
            ],
          )),
    );
  }
}

class UnitCard1 extends StatelessWidget {
  final String unitId, unitName;
  final Function() onTap;
  final double height;
  final bool isNew;

  const UnitCard1(
      {required this.unitId,
      required this.unitName,
      required this.onTap,
      this.isNew = false,
      this.height = .14});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * height,
        child: Image.asset('assets/images/kitchen_unit/$unitId.jpg'),
      ),
    );
  }
}
