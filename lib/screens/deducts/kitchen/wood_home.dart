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
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/cubit/wood_cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/unit_list.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/models/wood_kitchen_data.dart';
import 'package:the_smart_workshop/screens/deducts/kitchen/view/kitchen_edit_details.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/cubit.dart';
import 'package:the_smart_workshop/sql/kitchen/cubit/state.dart';
import 'package:the_smart_workshop/sql/kitchen/wood_unit_details.dart';

import 'view/add_new_body.dart';
import 'view/units_style/corner_details.dart';

class KitchenWood extends StatelessWidget {
  static String id = 'woodKitchen';
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
                return BlocConsumer<WoodCubit, WoodState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      WoodCubit woodCubit = BlocProvider.of(context);
                      return BlocConsumer<KitchenSettingCubit,
                              KitchenSettingState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            KitchenSettingCubit kitchenSettingCubit =
                                BlocProvider.of(context);
                            return BlocConsumer<CornerCubit, CornerState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                CornerCubit cornerCubit =
                                    BlocProvider.of(context);

                                return DOnWillPop(
                                    toExit: () {
                                      Navigator.of(context).pop(true);
                                      woodCubit.clearLists();
                                      componentCubit.clearData();
                                      addKitchenCubit.clearData();
                                    },
                                    child: DeductHome(
                                      appBarTitle: 'مطبخ 18 مم',
                                      drawerNavigatePage: WoodUnitDetails(),
                                      addNewBody: AddNewKitchen(
                                          woodCubit.allUnits, true),
                                      showResultBody: ResultHome(
                                        isCorner:
                                            woodCubit.cornerList.isNotEmpty
                                                ? true
                                                : false,
                                        cornerDetails: CornerDetails(true),
                                      ),
                                      detailsEdit: KitchenEditDetails(true),
                                      showResultAction: () async {
                                        await woodCubit.addItemsToList();
                                        await woodCubit.sortLists();
                                        await woodCubit.materialsList();
                                        componentCubit.resultDataListChange(
                                            woodCubit.titleList());

                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                showWaiting(context, 1));
                                      },
                                      onTapAddNew: () async {
                                        await kitchenSettingCubit.getAllPrefs();

                                        if (addKitchenCubit.unitId == -1) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(dSnackBarShowResult(
                                            icon: Icons.error,
                                            title:
                                                'من فضلك حدد نوع الوحدة أولاً .',
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
                                                  unitType:
                                                      addKitchenCubit.unitType,
                                                  imageId: data.imageId,
                                                  sk: kitchenSettingCubit
                                                          .woodThickness *
                                                      .1,
                                                  shutterWidthDeduct:
                                                      kitchenSettingCubit
                                                          .woodDeductShutter,
                                                  shutterFillDeduct: 0,
                                                  width: cornerCubit.backLeft,
                                                  height: cornerCubit.backRight,
                                                  deepLeft:
                                                      cornerCubit.deepLeft,
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
                                                  isShutterOnceColor: addKitchenCubit
                                                      .isOnceColor,
                                                  isShutterMultiColor:
                                                      addKitchenCubit
                                                          .isMultiColor,
                                                  isShutterMixColor:
                                                      addKitchenCubit
                                                          .isMixColor,
                                                  isShutterPolyLac: addKitchenCubit
                                                      .isShutterPolyLac,
                                                  isDeepNearly: false,
                                                  isDeepRemotely: false,
                                                  isHeadCorner: false,
                                                  isRack25: false,
                                                  rackDeduct:
                                                      kitchenSettingCubit
                                                          .rackDeduct,
                                                  isEnd: data.isEnd,
                                                  is90: data.is90,
                                                  shutterDoubleFillDeduct: 7.3);
                                              woodCubit
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
                                              WoodKitchenData w = WoodKitchenData(
                                                  id: componentCubit.id,
                                                  unitId: data.unitId,
                                                  imageId: data.imageId,
                                                  unitType:
                                                      addKitchenCubit.unitType,
                                                  unitName: data.unitName,
                                                  width: componentCubit.width,
                                                  height: componentCubit.height,
                                                  deep: componentCubit.deep,
                                                  widthShutterLength:
                                                      data.widthShutterLength,
                                                  heightShutterLength:
                                                      data.heightShutterLength,
                                                  rackLength:
                                                      componentCubit.length,
                                                  drawerLength:
                                                      data.drawerLength,
                                                  thickness: kitchenSettingCubit
                                                      .woodThickness,
                                                  shutterDeduct:
                                                      kitchenSettingCubit
                                                          .woodDeductShutter,
                                                  rackDeduct: kitchenSettingCubit
                                                      .rackDeduct,
                                                  isUp: kitchenSettingCubit
                                                      .isWoodUp,
                                                  isOpened: data.isOpened,
                                                  isFixed: data.isFixed,
                                                  isWithTilt: data.isWithTilt,
                                                  isBasket: data.isBasket,
                                                  openedUnitHeight: addKitchenCubit
                                                      .openedUnit,
                                                  fixedWidth:
                                                      addKitchenCubit.fixed,
                                                  heightDrawerShutter:
                                                      addKitchenCubit
                                                          .heightDrawerShutter,
                                                  heightDrawerBody:
                                                      kitchenSettingCubit
                                                          .heightDrawerBody,
                                                  withoutShutter:
                                                      data.withoutShutter,
                                                  isDrawer: data.isDrawer,
                                                  isShutterGlass: addKitchenCubit
                                                      .isShutterGlass,
                                                  isShutterOnceColor:
                                                      addKitchenCubit
                                                          .isOnceColor,
                                                  isShutterMultiColor:
                                                      addKitchenCubit
                                                          .isMultiColor,
                                                  isShutterMixColor: addKitchenCubit
                                                      .isMixColor,
                                                  entryWidthMulti: addKitchenCubit.isSize2_2
                                                      ? (componentCubit.width - (kitchenSettingCubit.woodThickness * .1 * 3)) * (1 / 2)
                                                      : (componentCubit.width - (kitchenSettingCubit.woodThickness * .1 * 3)) * (data.widthMultiShutterLength == 2 ? 2 / 3 : 1 / 3),
                                                  isShutterWithDrawer: data.isShutterWithDrawer,
                                                  heightMultiShutterLength: data.heightMultiShutterLength,
                                                  widthMultiShutterLength: data.widthMultiShutterLength,
                                                  isMultiHeight: data.isMultiHeight,
                                                  isMultiWidth: data.isMultiWidth,
                                                  entryHeightMulti: data.isBigLowerHeight && componentCubit.height > 180 ? 140 : 75);
                                              woodCubit.insertUnitToList(w);
                                              componentCubit.incrementId();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      dSnackBarShowResult(
                                                icon: Icons.done_all,
                                                title:
                                                    'تمت إضافة وحدة ${w.unitName} بنجاح .',
                                              ));
                                            }
                                          }
                                        }
                                      },
                                    ));
                              },
                            );
                          });
                    });
              });
        });
  }
}
