import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/view/corner.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list/corner_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/unit_card.dart';

class CornerUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;

          ComponentCubit componentCubit = BlocProvider.of(context);
          return BlocConsumer<AddKitchenCubit, AddKitchenState>(
              listener: (context, state) {},
              builder: (context, state) {
                AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(cornerUnit.length, (i) {
                          return Container(
                            width: size.width * .32,
                            height: size.height * .2,
                            child: UnitCard(
                              isNew: cornerUnit[i].isNew,
                              unitId: cornerUnit[i].imageId.toString(),
                              unitName: cornerUnit[i].unitName,
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Corner(true));
                                addKitchenCubit.changeUnitData(
                                  cornerUnit[i].unitId,
                                  cornerUnit[i].unitName,
                                  cornerUnit[i].imageId,
                                );

                                componentCubit.priceValueChange(
                                    cornerUnit[i].rackLength,
                                    cornerUnit[i].isMultiWidth);
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
