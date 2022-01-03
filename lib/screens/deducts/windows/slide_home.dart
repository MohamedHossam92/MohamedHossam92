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
import 'package:the_smart_workshop/screens/deducts/windows/models/slide_data.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/add_new_windows.dart';
import 'package:the_smart_workshop/screens/deducts/windows/view/windows_details_edit.dart';
import 'package:the_smart_workshop/sql/home.dart';
import 'package:the_smart_workshop/sql/slide_windows/const.dart';
import 'package:the_smart_workshop/sql/slide_windows/cubit/cubit.dart';

import 'cubit/slide_cubit/cubit.dart';
import 'cubit/slide_cubit/state.dart';

class AluminumSlideHome extends StatelessWidget {
  static String id = 'AluminumSlideHome';
  final String cSWindowsProfileType;

  AluminumSlideHome([this.cSWindowsProfileType = '']);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SlideCubit, SlideState>(
        listener: (context, state) {},
        builder: (context, state) {
          SlideCubit slideCubit = BlocProvider.of(context);

          return BlocConsumer<ComponentCubit, ComponentState>(
              listener: (context, state) {},
              builder: (context, state) {
                ComponentCubit componentCubit = BlocProvider.of(context);
                return DOnWillPop(
                    toExit: () {
                      Navigator.of(context).pop(true);
                      slideCubit.clearWindowsList();
                      componentCubit.clearData();
                    },
                    child: Scaffold(
                      key: _scaffoldKey,
                      body: DeductHome(
                          appBarTitle: 'تخصيم $cSWindowsProfileType',
                          drawerNavigatePage: SlideDeductSetting(),
                          addNewBody: AddNewWindows(
                              list: slideCubit.windowsList, isSlide: true),
                          showResultBody: slideCubit.windowsList.isNotEmpty
                              ? ResultHome()
                              : ListIsEmpty(),
                          showResultAction: () async {
                            await slideCubit.addItemsToList();

                            await slideCubit.sortLists();

                            await slideCubit.materialsList();
                            componentCubit
                                .resultDataListChange(slideCubit.titleList());

                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => showWaiting(context, 0));
                          },
                          detailsEdit: windowsEditDetails(true),
                          onTapAddNew: () {
                            for (var data in slideDeductListDb!) {
                              if (data[cSWindowsProfile] ==
                                  cSWindowsProfileType) {
                                SlideData s = SlideData(
                                    id: componentCubit.id,
                                    windowsType: cSWindowsProfileType,
                                    windowsWidth: componentCubit.width,
                                    windowsHeight: componentCubit.height,
                                    windowsLength: componentCubit.length,
                                    sashLength: componentCubit.sashLength,
                                    widthSashDeduct2: data[cSWidthSashDeduct2],
                                    widthSashDeduct4: data[cSWidthSashDeduct4],
                                    widthSashDeduct32:
                                        data[cSWidthSashDeduct32],
                                    widthSashDeduct33:
                                        data[cSWidthSashDeduct33],
                                    widthFlyScreenDeduct2:
                                        data[cSWidthFlyScreenDeduct2],
                                    widthFlyScreenDeduct4:
                                        data[cSWidthFlyScreenDeduct4],
                                    widthFlyScreenDeduct32:
                                        data[cSWidthFlyScreenDeduct32],
                                    widthFlyScreenDeduct33:
                                        data[cSWidthFlyScreenDeduct33],
                                    heightSashDeduct: data[cSHeightSashDeduct],
                                    heightFluScreenDeduct:
                                        data[cSHeightFluScreenDeduct],
                                    heightHookDeduct: data[cSHeightHookDeduct],
                                    heightAdjoiningDeduct:
                                        data[cSHeightAdjoiningDeduct],
                                    widthGlassDeduct: data[cSWidthGlassDeduct],
                                    heightGlassDeduct:
                                        data[cSHeightGlassDeduct],
                                    barDeduct: componentCubit.barSize ?? 10 * 2,
                                    trackDeduct: data[cSTrackDeduct],
                                    weightFrame: data[cSWeightFrame],
                                    weightFrameWithoutBar:
                                        data[cSWeightFrameWithoutBar],
                                    weightSash: data[cSWeightSash],
                                    weightFlyScreen: data[cSWeightFlyScreen],
                                    weightHook: data[cSWeightHook],
                                    weightAdjoining: data[cSWeightAdjoining],
                                    isTopFixed: componentCubit.isTopFixed,
                                    isBottomFixed: componentCubit.isBottomFixed,
                                    isRightFixed: componentCubit.isRightFixed,
                                    isLeftFixed: componentCubit.isLeftFixed,
                                    topFixedLength:
                                        componentCubit.topFixedLength,
                                    bottomFixedLength:
                                        componentCubit.bottomFixedLength,
                                    rightFixedLength:
                                        componentCubit.rightFixedLength,
                                    leftFixedLength:
                                        componentCubit.leftFixedLength,
                                    topFixedSize: componentCubit.topFixedSize,
                                    bottomFixedSize:
                                        componentCubit.bottomFixedSize,
                                    rightFixedSize:
                                        componentCubit.rightFixedSize,
                                    leftFixedSize: componentCubit.leftFixedSize,
                                    weightFix: data[cSWeightFix],
                                    weightBar: data[cSWeightBar],
                                    weightCollect: data[cSWeightCollect],
                                    weightBead: data[cSWeightBead],
                                    weightT: data[cSWeightT],
                                    fixSize: data[cSFrameFixSize],
                                    tSize: componentCubit.tSize,
                                    isPVC: data[cSWindowsSystem] == qPVC
                                        ? true
                                        : false,
                                    beadSize: data[cSBeadSize]);

                                if ((s.isTopFixed ||
                                        s.isBottomFixed ||
                                        s.isLeftFixed ||
                                        s.isRightFixed) &&
                                    componentCubit.tSize == null)
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(dSnackBarShowResult(
                                    icon: Icons.done_all,
                                    title: 'يجب تحديد مقاس السؤاس أولاً .',
                                  ));
                                else if ((s.isTopFixed ||
                                        s.isBottomFixed ||
                                        s.isLeftFixed ||
                                        s.isRightFixed) &&
                                    componentCubit.barSize == null)
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(dSnackBarShowResult(
                                    icon: Icons.done_all,
                                    title: 'يجب تحديد مقاس البار أولاً .',
                                  ));
                                else {
                                  slideCubit.insertWindowsToList(s);
                                  componentCubit.incrementId();
                                  componentCubit.clearFixedData();

                                  componentCubit.restWindowsLength();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(dSnackBarShowResult(
                                    icon: Icons.done_all,
                                    title:
                                        'تمت إضافة مقاس ${componentCubit.width} * ${componentCubit.height} بنجاح .',
                                  ));
                                }
                              }
                            }
                            ;
                          }),
                    ));
              });
        });
  }
}
