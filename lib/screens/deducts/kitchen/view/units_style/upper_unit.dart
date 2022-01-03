import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list/upper_unit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/units_style/unit_card.dart';

import 'lower_unit.dart';

class UpperUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentCubit, ComponentState>(
        listener: (context, state) {},
        builder: (context, state) {
          ComponentCubit componentCubit = BlocProvider.of(context);
          return BlocConsumer<AddKitchenCubit, AddKitchenState>(
              listener: (context, state) {},
              builder: (context, state) {
                AddKitchenCubit addKitchenCubit = BlocProvider.of(context);
                Size size = MediaQuery.of(context).size;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        children: List.generate(upperUnit.length, (i) {
                          return Container(
                            width: size.width * .32,
                            height: size.height * .2,
                            child: UnitCard(
                              isNew: upperUnit[i].isNew,
                              unitId: upperUnit[i].imageId.toString(),
                              unitName: upperUnit[i].unitName,
                              onTap: () {
                                Navigator.pop(context);
                                componentCubit.priceValueChange(
                                    upperUnit[i].rackLength,
                                    upperUnit[i].isMultiWidth);
                                addKitchenCubit.changeUnitData(
                                  upperUnit[i].unitId,
                                  upperUnit[i].unitName,
                                  upperUnit[i].imageId,
                                );

                                if (upperUnit[i].isMultiWidth ||
                                    upperUnit[i].isDrawer &&
                                        !upperUnit[i].withoutShutter ||
                                    upperUnit[i].isOpened ||
                                    upperUnit[i].isFixed ||
                                    upperUnit[i].isWithTilt)
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => Dialog(
                                          child: DialogW(
                                              upperUnit[i].imageId.toString(),
                                              upperUnit[i]
                                                  .widthMultiShutterLength,
                                              i,
                                              upperUnit)));
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
