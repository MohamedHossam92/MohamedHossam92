import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/widget/exit_message.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/deduct_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/result_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/text_form.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/wait_to_get_data.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/angles/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/angles/models/corner_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/al_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/al_kitchen_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list.dart';
import 'package:the_smart_workshop/sql/kitchen/aluminum_unit_details.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/state.dart';

import 'view/add_new_body.dart';
import 'view/kitchen_edit_details.dart';
import 'view/units_style/corner_details.dart';

class KitchenAluminum extends StatelessWidget {
  static String id = 'KitchenAluminium';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddKitchenCubit, AddKitchenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AddKitchenCubit addKitchenCubit = BlocProvider.of(context);

          return BlocConsumer<ComponentCubit, ComponentState>(
              listener: (context, state) {},
              builder: (context, state) {
                ComponentCubit componentCubit = BlocProvider.of(context);
                return BlocConsumer<KitchenCubit, KitchenState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      KitchenCubit kitchenCubit = BlocProvider.of(context);

                      return BlocConsumer<CornerCubit, CornerState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            CornerCubit cornerCubit = BlocProvider.of(context);
                            return BlocConsumer<KitchenSettingCubit,
                                KitchenSettingState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                KitchenSettingCubit kitchenDetailsCubit =
                                    BlocProvider.of(context);

                                return DOnWillPop(
                                  toExit: () {
                                    Navigator.of(context).pop(true);
                                    kitchenCubit.clearLists();
                                    componentCubit.clearData();
                                    addKitchenCubit.clearData();
                                  },
                                  child: DeductHome(
                                    appBarTitle: 'مطبخ ألومنيوم',
                                    drawerNavigatePage: AlKitchenSitting(),
                                    addNewBody: AddNewKitchen(
                                        kitchenCubit.listOfUnits, false),
                                    showResultBody: ResultHome(
                                      isCorner:
                                          kitchenCubit.cornerUnits.isNotEmpty
                                              ? true
                                              : false,
                                      cornerDetails: CornerDetails(),
                                    ),
                                    detailsEdit: KitchenEditDetails(false),
                                    showResultAction: () {
                                      kitchenCubit.addItemsToList();
                                      kitchenCubit.sortLists();
                                      kitchenCubit.materialsList();

                                      componentCubit.resultDataListChange(
                                          kitchenCubit.titleList());
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) =>
                                              showWaiting(context, 1));
                                    },
                                    onTapAddNew: () async {
                                      await kitchenDetailsCubit.getAllPrefs();

                                      if (addKitchenCubit.unitId == -1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(dSnackBarShowResult(
                                          icon: Icons.error,
                                          title:
                                              'من فضلك حدد نوع الوحدة أولاً .',
                                        ));
                                      } else if (addKitchenCubit
                                              .selectedShutter ==
                                          null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(dSnackBarShowResult(
                                          icon: Icons.error,
                                          title:
                                              'من فضلك حدد نوع الدرف أولاً من  مواصفات الدرف.',
                                        ));
                                      } else if (addKitchenCubit.unitType ==
                                          3) {
                                        for (var data in units[
                                            addKitchenCubit.unitType]) {
                                          if (data.unitId ==
                                              addKitchenCubit.unitId) {
                                            CornerData c = CornerData(
                                                id: componentCubit.id,
                                                unitId: data.unitId,
                                                unitType: data.unitType,
                                                imageId: data.imageId,
                                                sk: kitchenDetailsCubit.skSize,
                                                shutterWidthDeduct:
                                                    kitchenDetailsCubit
                                                        .deductShutter,
                                                shutterFillDeduct: addKitchenCubit
                                                    .deductShutterFill,
                                                shutterDoubleFillDeduct:
                                                    addKitchenCubit
                                                        .deductShutterFillDouble,
                                                width: cornerCubit.backLeft,
                                                height: cornerCubit.backRight,
                                                deepLeft: cornerCubit.deepLeft,
                                                deepRight:
                                                    cornerCubit.deepRight,
                                                cornerHeight:
                                                    cornerCubit.height,
                                                backAngle:
                                                    cornerCubit.backAngle,
                                                rackLength:
                                                    componentCubit.length,
                                                shutterLength:
                                                    data.widthShutterLength,
                                                unitName:
                                                    addKitchenCubit.unitName,
                                                isShutterDouble: addKitchenCubit
                                                    .isShutterDouble,
                                                isShutterGlass: addKitchenCubit
                                                    .isShutterGlass,
                                                isShutterOnceColor:
                                                    addKitchenCubit.isOnceColor,
                                                isShutterMultiColor:
                                                    addKitchenCubit
                                                        .isMultiColor,
                                                isShutterMixColor:
                                                    addKitchenCubit.isMixColor,
                                                isShutterPolyLac: addKitchenCubit
                                                    .isShutterPolyLac,
                                                isDeepNearly: kitchenDetailsCubit
                                                    .isDeepNearly,
                                                isDeepRemotely: kitchenDetailsCubit
                                                    .isDeepRemotely,
                                                isHeadCorner:
                                                    kitchenDetailsCubit
                                                        .isHeadCorner,
                                                isRack25:
                                                    kitchenDetailsCubit.isRaf25,
                                                is90: data.is90,
                                                isEnd: data.isEnd);
                                            kitchenCubit
                                                .insertCornerUnitToList(c);
                                            componentCubit.incrementId();
                                          }
                                        }
                                      } else if (formKey.currentState!
                                          .validate()) {
                                        for (var data in units[
                                            addKitchenCubit.unitType]) {
                                          if (data.unitId ==
                                              addKitchenCubit.unitId) {
                                            AluminiumKitchenData k = AluminiumKitchenData(
                                                id: componentCubit.id,
                                                unitId: data.unitId,
                                                imageId:
                                                    addKitchenCubit.imageId,
                                                unitType:
                                                    addKitchenCubit.unitType,
                                                unitName: data.unitName,
                                                shutterType: addKitchenCubit
                                                    .selectedShutter,
                                                width: componentCubit.width,
                                                height: componentCubit.height,
                                                deep: componentCubit.deep,
                                                widthShutterLength:
                                                    data.widthShutterLength,
                                                heightShutterLength:
                                                    data.heightShutterLength,
                                                entryHeightMulti:
                                                    data.isBigLowerHeight && componentCubit.height > 180
                                                        ? 140
                                                        : 75,
                                                entryWidthMulti: addKitchenCubit.isSize2_2
                                                    ? (componentCubit.width -
                                                            (kitchenDetailsCubit.skSize *
                                                                3)) *
                                                        (1 / 2)
                                                    : (componentCubit.width -
                                                            (kitchenDetailsCubit.skSize *
                                                                3)) *
                                                        (data.widthMultiShutterLength == 2
                                                            ? 2 / 3
                                                            : 1 / 3),
                                                heightMultiShutterLength: data
                                                    .heightMultiShutterLength,
                                                widthMultiShutterLength:
                                                    data.widthMultiShutterLength,
                                                isMultiHeight: data.isMultiHeight,
                                                isMultiWidth: data.isMultiWidth,
                                                rackLength: componentCubit.length,
                                                drawerLength: data.drawerLength,
                                                sk: kitchenDetailsCubit.skSize,
                                                isBackOut: kitchenDetailsCubit.isBackOut,
                                                isBackIn: kitchenDetailsCubit.isBackIn,
                                                isBackInOut: kitchenDetailsCubit.isBackInOut,
                                                isHeadCorner: kitchenDetailsCubit.isHeadCorner,
                                                isFaceUnit: kitchenDetailsCubit.isFaceUnit,
                                                shutterWidthDeduct: kitchenDetailsCubit.deductShutter,
                                                shutterFillDeduct: addKitchenCubit.deductShutterFill,
                                                shutterDoubleFillDeduct: addKitchenCubit.deductShutterFillDouble,
                                                isOpened: data.isOpened,
                                                isWithTilt: data.isWithTilt,
                                                isFixed: data.isFixed,
                                                openedUnitHeight: addKitchenCubit.openedUnit,
                                                fixedWidth: addKitchenCubit.fixed,
                                                withoutShutter: data.withoutShutter,
                                                isShutterPolyLac: addKitchenCubit.isShutterPolyLac,
                                                isShutterWithDrawer: data.isShutterWithDrawer,
                                                heightDrawer: addKitchenCubit.heightDrawerShutter,
                                                isDeepNearly: kitchenDetailsCubit.isDeepNearly,
                                                isDeepRemotely: kitchenDetailsCubit.isDeepRemotely,
                                                isDrawer45: kitchenDetailsCubit.isDrawer45,
                                                isDrawer: data.isDrawer,
                                                isRack25: kitchenDetailsCubit.isRaf25,
                                                isShutterDouble: addKitchenCubit.isShutterDouble,
                                                isShutterGlass: addKitchenCubit.isShutterGlass,
                                                isShutterOnceColor: addKitchenCubit.isOnceColor,
                                                isShutterMultiColor: addKitchenCubit.isMultiColor,
                                                isShutterMixColor: addKitchenCubit.isMixColor,
                                                isBasket: data.isBasket,
                                                isSlide: data.isSlide);
                                            kitchenCubit.insertUnitToList(k);
                                            componentCubit.incrementId();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    dSnackBarShowResult(
                                              icon: Icons.done_all,
                                              title:
                                                  'تمت إضافة وحدة ${k.unitName} بنجاح .',
                                            ));
                                          }
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          });
                    });
              });
        });
  }
}
