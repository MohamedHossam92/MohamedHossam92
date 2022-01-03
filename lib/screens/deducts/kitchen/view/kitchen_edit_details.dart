import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';

class KitchenEditDetails extends StatelessWidget {
  final bool isWood;

  const KitchenEditDetails(this.isWood);
  @override
  Widget build(BuildContext context) {
    final List<DetailsData> detailsDataList = [
      DetailsData(
          icons: Icons.calendar_view_day_sharp,
          title: 'توزيع ألوان الدرفة',
          widget: SashColor()),
      DetailsData(
          icons: Icons.layers, title: 'نوع قطاع الدرفة', widget: SashType()),
    ];
    return Container(
      color: Colors.black,
      child: Row(
          children: List.generate(
              isWood ? 1 : 2,
              (i) => TextButton(
                    child: Row(
                      children: [
                        DPadding(
                          val: .01,
                          child: Icon(
                            detailsDataList[i].icons,
                            color: Colors.yellow,
                          ),
                        ),
                        WTextB5(detailsDataList[i].title)
                      ],
                    ),
                    onPressed: () {
                      showBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => detailsDataList[i].widget);
                    },
                  ))),
    );
  }
}

class SashType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AddKitchenCubit, AddKitchenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddKitchenCubit addKitchenCubit = BlocProvider.of(context);

          return Container(
            height: size.height * .7,
            color: Colors.black54,
            width: size.width * .5,
            child: SingleChildScrollView(
              child: Column(
                children: addKitchenCubit.shutterName.keys
                    .toList()
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            addKitchenCubit.isSelectedShutterChange(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                                dSnackBarShowResult(
                                    title: 'تم اختيار درفة $e'));
                          },
                          child: SizedBox(
                              width: size.width * .45,
                              child: Card(child: DPadding(child: BTextB5(e)))),
                        ))
                    .toList(),
              ),
            ),
          );
        });
  }
}

class SashColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddKitchenCubit, AddKitchenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
          List<String> data = [
            'لون أساسي',
            'لون ثانوي',
            'لون أساسي وثانوي',
            'درفة زجاج'
          ];
          Size size = MediaQuery.of(context).size;

          return SizedBox(
            width: double.infinity,
            height: size.height * .25,
            child: Center(
              child: Container(
                color: Colors.black54,
                width: size.width * .6,
                child: Column(
                  children: data
                      .map((e) => GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              addKitchenCubit.isColorChange(
                                  data.indexOf(e), true, e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  dSnackBarShowResult(
                                      title: 'تم اختيار درفة $e'));
                            },
                            child: SizedBox(
                                width: size.width * .5,
                                child: Card(
                                    child: DPadding(
                                        child: Center(child: BTextB5(e))))),
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        });
  }
}

class fixedData {
  final String title;
  final double fixSize;
  final int fixLength;
  final bool isChoose;

  fixedData(this.title, this.fixLength, this.fixSize, this.isChoose);
}

class DetailsData {
  final IconData icons;
  final String title;
  final Widget widget;

  DetailsData({required this.icons, required this.title, required this.widget});
}
