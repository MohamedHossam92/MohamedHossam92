import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/widget/exit_message.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/const/profiles_name.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/deduct_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/list_is_empty.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/result_home.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/wait_to_get_data.dart';
import 'package:the_smart_workshop/screens/deducts/windows/models/turn_data.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/add_new_windows.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/windows_details_edit.dart';
import 'package:the_smart_workshop/sql/home.dart';
import 'package:the_smart_workshop/sql/turn_windows/const.dart';
import 'package:the_smart_workshop/sql/turn_windows/cubit/cubit.dart';

import 'cubit/turn_cubit/cubit.dart';
import 'cubit/turn_cubit/state.dart';

class AluminumTiltHome extends StatelessWidget {
  static String id = 'AluminumTurnHome';
  final String cTWindowsProfiles;

  const AluminumTiltHome([this.cTWindowsProfiles = '']);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TurnCubit, TurnState>(
        listener: (context, state) {},
        builder: (context, state) {
          TurnCubit turnCubit = BlocProvider.of(context);

          return BlocConsumer<ComponentCubit, ComponentState>(
              listener: (context, state) {},
              builder: (context, state) {
                ComponentCubit componentCubit = BlocProvider.of(context);

                return DOnWillPop(
                    toExit: () {
                      Navigator.of(context).pop(true);
                      turnCubit.clearWindowsList();
                      componentCubit.clearData();
                    },
                    child: DeductHome(
                      appBarTitle: 'تخصيم $cTWindowsProfiles',
                      drawerNavigatePage: SlideDeductSetting(true, false),
                      addNewBody: AddNewWindows(
                        list: turnCubit.windowsList,
                        isSlide: false,
                        isTilt: true,
                      ),
                      showResultBody: turnCubit.windowsList.isNotEmpty
                          ? ResultHome()
                          : ListIsEmpty(),
                      showResultAction: () {
                        turnCubit.addItemsToList();
                        turnCubit.sortLists();
                        turnCubit.materialsList();
                        componentCubit
                            .resultDataListChange(turnCubit.titleList());

                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => showWaiting(context, 0));
                      },
                      detailsEdit: windowsEditDetails(false, true),
                      onTapAddNew: () {
                        for (var data in turnDeductListDb) {
                          if (data[cTWindowsProfile] == cTWindowsProfiles) {
                            TurnData m = TurnData(
                                id: componentCubit.id,
                                windowsType: cTWindowsProfiles,
                                windowsWidth: componentCubit.width,
                                windowsHeight: componentCubit.height,
                                windowsLength: componentCubit.length,
                                deductFrameWithBar: data[cTDeductFrameWithBar],
                                deductFrameWithFex: data[cTDeductFrameWithFex],
                                tSize: componentCubit.tSize ?? 5,
                                barDeduct: componentCubit.barSize ?? 10 * 2,
                                bead: data[cTBead],
                                fixedSize: componentCubit.sashFixedSize,
                                isPanda: componentCubit.isPanda,
                                isSashFixed: componentCubit.isSashFixed,
                                sashLength: componentCubit.sashLength,
                                isLargeZ: componentCubit.isZ,
                                isFexFrame: componentCubit.isFexFrame,
                                isTopFixed: componentCubit.isTopFixed,
                                isBottomFixed: componentCubit.isBottomFixed,
                                isRightFixed: componentCubit.isRightFixed,
                                isLeftFixed: componentCubit.isLeftFixed,
                                topFixedLength: componentCubit.topFixedLength,
                                bottomFixedLength:
                                    componentCubit.bottomFixedLength,
                                rightFixedLength:
                                    componentCubit.rightFixedLength,
                                leftFixedLength: componentCubit.leftFixedLength,
                                topFixedSize: componentCubit.topFixedSize,
                                bottomFixedSize: componentCubit.bottomFixedSize,
                                rightFixedSize: componentCubit.rightFixedSize,
                                leftFixedSize: componentCubit.leftFixedSize,
                                isPVC:
                                    data[cTSystemType] == qPVC ? true : false,
                                isTilt: true,
                                deductLargeZ: data[cTDeductLargeZ],
                                deductSmallZ: data[cTDeductSmallZ],
                                deductTCenter: data[cTDeductTCenter],
                                underSize: componentCubit.underSize ?? 5,
                                isWithoutUnder: componentCubit.isWithoutUnder,
                                sash1Deduct: data[cTOneSashDeDuct],
                                sash2Deduct: data[cTTowSashDeDuct],
                                sashHeightDeduct: data[cTHeightSashDeduct]);
                            if (m.isFexFrame &&
                                componentCubit.barSize == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title: 'يجب تحديد مقاس البار أولاً .',
                              ));
                            } else if (m.sashLength > 1 &&
                                componentCubit.tSize == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title: 'يجب تحديد مقاس السؤاس أولاً .',
                              ));
                            } else if (componentCubit.tSize == null &&
                                (m.isTopFixed ||
                                    m.isBottomFixed ||
                                    m.isLeftFixed ||
                                    m.isRightFixed ||
                                    m.isSashFixed)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title: 'يجب تحديد مقاس السؤاس أولاً .',
                              ));
                            } else if (m.isWithoutUnder &&
                                componentCubit.underSize == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title: 'يجب تحديد مقاس الجلسة أولاً .',
                              ));
                            } else if ((componentCubit.isSuction[0] &&
                                    componentCubit.suctionSize[0] == null &&
                                    componentCubit.suctionPlace[0] == null) ||
                                (componentCubit.isSuction[1] &&
                                    componentCubit.suctionSize[1] == null &&
                                    componentCubit.suctionPlace[1] == null) ||
                                (componentCubit.isSuction[2] &&
                                    componentCubit.suctionSize[2] == null &&
                                    componentCubit.suctionPlace[2] == null) ||
                                (componentCubit.isSuction[3] &&
                                    componentCubit.suctionSize[3] == null &&
                                    componentCubit.suctionPlace[3] == null)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title: 'يجب تحديد مقاس ومكان الشفاط أولاً .',
                              ));
                            } else {
                              turnCubit.insertWindowsToList(m);
                              componentCubit.incrementId();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(dSnackBarShowResult(
                                icon: Icons.done_all,
                                title:
                                    'تمت إضافة مقاس ${componentCubit.width} * ${componentCubit.height} بنجاح .',
                              ));
                            }

                            break;
                          }
                        }
                      },
                    ));
              });
        });
  }
}
