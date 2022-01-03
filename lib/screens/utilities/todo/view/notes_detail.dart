import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/cubit/state.dart';
import 'package:the_smart_workshop/screens/deducts/a-component/text_form.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/todo/model/notes_details_data.dart';

import 'home.dart';

class NoteDetails extends StatelessWidget {
  final int noteId;
  final String noteTitle;

  NoteDetails({required this.noteId, required this.noteTitle});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          NoteCubit noteCubit = BlocProvider.of(context);
          return BlocConsumer<AddNoteCubit, AddNoteState>(
              listener: (context, state) {},
              builder: (context, state) {
                AddNoteCubit addNoteCubit = BlocProvider.of(context);

                double allArea = 0, allPrice = 0, allLength = 0;
                for (var data in addNoteCubit.notesDetailsList)
                  if (data[columnNotesId] == noteId) {
                    allArea += data[columnTotalArea];
                    allPrice += data[columnTotalPrice];
                    allLength += data[columnWindowsLength];
                  }
                List<String> content = [
                  '${allLength.toStringAsFixed(0)}',
                  '${allArea.toStringAsFixed(2)} م ',
                  '${allPrice.toStringAsFixed(0)} جنية '
                ];
                List<String> title = [
                  'إجمالي المقاسات',
                  'إجمالي المساحة ',
                  'إجمالي التكلفة '
                ];
                return BlocConsumer<ComponentCubit, ComponentState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      ComponentCubit componentCubit = BlocProvider.of(context);
//===============================================================================
                      return Scaffold(
                        key: _scaffoldKey,
                        appBar: AppBar(title: Text('نوتة مقاسات')),
                        body: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            children: [
                              DPadding(
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle),
                                    noteTitle.length > 30
                                        ? BTextB5(noteTitle.substring(0, 30))
                                        : BTextB5(noteTitle),
                                  ],
                                ),
                              ),
                              SPadding(
                                h: .06,
                                v: .018,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(3, (i) {
                                    return Column(
                                      children: [
                                        BTextB3(title[i]),
                                        DPadding(
                                          val: .015,
                                          child: BTextB5('${content[i]}'),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
//===============================================================================
                              Expanded(
                                  child: DPadding(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: cLogoColorW, width: 3),
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(
                                          size.width * .05)),
                                  child: SingleChildScrollView(
                                      child:
                                          addNoteCubit
                                                  .notesDetailsList.isNotEmpty
                                              ? Column(
                                                  children: addNoteCubit
                                                      .notesDetailsList.reversed
                                                      .map((e) {
                                                    if (noteId ==
                                                        e[columnNotesId]) {
                                                      List<DetailsIcon>
                                                          detailsList = [
                                                        DetailsIcon(
                                                            '${e[columnWindowsArea].toStringAsFixed(2)} م',
                                                            Icons.padding),
                                                        DetailsIcon(
                                                            '${e[columnOncePrice].toStringAsFixed(0)} جنية ',
                                                            Icons.attach_money),
                                                        DetailsIcon(
                                                            '${e[columnTotalArea].toStringAsFixed(2)} م ',
                                                            Icons.margin),
                                                        DetailsIcon(
                                                            '${e[columnTotalPrice].toStringAsFixed(0)} جنية ',
                                                            Icons
                                                                .monetization_on_outlined),
                                                      ];
                                                      return DPadding(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      cLogoColor,
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      size.width *
                                                                          .04)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        cLogoColor,
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(size.width *
                                                                                .045),
                                                                        topLeft:
                                                                            Radius.circular(size.width *
                                                                                .045))),
                                                                child: DPadding(
                                                                  child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              DPadding(
                                                                            child:
                                                                                WTextB5(e[columnWindowsTitle]),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Card(
                                                                              child: DPadding(
                                                                                val: .01,
                                                                                child: Center(
                                                                                  child: BTextB3('سعر المتر : ${e[columnWindowsPrice].toStringAsFixed(0)}'),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      ]),
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                    size.height *
                                                                        .06,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      BTextB5(
                                                                          '${e[columnWindowsWidth]}'),
                                                                      BTextB4(
                                                                          '   X   '),
                                                                      BTextB5(
                                                                          '${e[columnWindowsHeight]}'),
                                                                      BTextB4(
                                                                          'عدد ${e[columnWindowsLength]}'),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            addNoteCubit.deleteOnceNotesDetailsDataFromDb(e[columnNoteDetailsId]);
                                                                            ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
                                                                                icon: Icons.done,
                                                                                title: 'تمت حذف ${e[columnWindowsTitle]} بنجاح . '));
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                cLogoColorW,
                                                                          )),
                                                                    ]),
                                                              ),
                                                              Divider(
                                                                thickness: 3,
                                                              ),
                                                              Container(
                                                                width:
                                                                    size.width,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children:
                                                                        detailsList
                                                                            .map((e) {
                                                                      return DPadding(
                                                                        val:
                                                                            .01,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Icon(e.icon,
                                                                                size: size.width * .05),
                                                                            BText4(e.title),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }).toList()),
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500,
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(size.width *
                                                                                .045),
                                                                        bottomLeft:
                                                                            Radius.circular(size.width *
                                                                                .045))),
                                                                child: DPadding(
                                                                  child: e[columnWindowsNote]
                                                                              .length >
                                                                          40
                                                                      ? WTextB5(e[
                                                                              columnWindowsNote]
                                                                          .substring(
                                                                              0,
                                                                              40))
                                                                      : WTextB5(
                                                                          e[columnWindowsNote]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  }).toList(),
                                                )
                                              : NoNotes()),
                                ),
                              )),

//===============================================================================
                              DPadding(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                        color: cLogoColorW,
                                        child: DPadding(
                                          child: WTextB5('إضافة مقاس جديد'),
                                        ),
                                        onPressed: () {
                                          _scaffoldKey.currentState!
                                              .showBottomSheet((context) {
                                            return Container(
                                                height: size.height * .33,
                                                child: SingleChildScrollView(
                                                    child: Column(children: [
                                                  Form(
                                                      key: _formKey,
                                                      child: Column(children: [
                                                        // AddHeader(),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              flex: 5,
                                                              child: DTextField(
                                                                child:
                                                                    TextFormField(
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'عنوان المقاس'),
                                                                  onChanged:
                                                                      (val) {
                                                                    noteCubit
                                                                        .widowsDetails(
                                                                            0,
                                                                            val);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 3,
                                                              child: DTextField(
                                                                child:
                                                                    TextFormField(
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'سعر المتر'),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  onChanged:
                                                                      (val) {
                                                                    componentCubit
                                                                        .priceChange(
                                                                            val);
                                                                  },
                                                                  validator:
                                                                      (val) {
                                                                    if (val!
                                                                        .isEmpty) {
                                                                      return 'يجب إدخال قيمة';
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        AddSize(),
                                                        DTextField(
                                                          child: TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'تفاصيل المقاس',
                                                            ),
                                                            onChanged: (val) {
                                                              noteCubit
                                                                  .widowsDetails(
                                                                      2, val);
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              MaterialButton(
                                                                  color:
                                                                      cLogoColorW,
                                                                  child: WTextB5(
                                                                      'إضافة مقاس جديد'),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      if (formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        NotesDetailsData
                                                                            n =
                                                                            NotesDetailsData({
                                                                          columnNotesId:
                                                                              noteId,
                                                                          columnWindowsTitle:
                                                                              noteCubit.windowsTitle,
                                                                          columnWindowsNote:
                                                                              noteCubit.windowsNote,
                                                                          columnWindowsWidth:
                                                                              componentCubit.width,
                                                                          columnWindowsHeight:
                                                                              componentCubit.height,
                                                                          columnWindowsPrice:
                                                                              componentCubit.windowsPrice,
                                                                          columnWindowsLength:
                                                                              componentCubit.length,
                                                                          columnWindowsArea:
                                                                              componentCubit.windowsArea(),
                                                                          columnTotalPrice:
                                                                              componentCubit.totalPrice(),
                                                                          columnTotalArea:
                                                                              componentCubit.totalArea(),
                                                                          columnOncePrice:
                                                                              componentCubit.oncePrice()
                                                                        });
                                                                        addNoteCubit
                                                                            .insertNoteDetailsToDb(n);
                                                                        ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(
                                                                            icon:
                                                                                Icons.done,
                                                                            title: 'تمت إضافة ${noteCubit.windowsTitle} بنجاح . '));
                                                                        noteCubit
                                                                            .clearData();
                                                                      }
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                              MaterialButton(
                                                                  color: Colors
                                                                      .black,
                                                                  child: WTextB5(
                                                                      'إنهاء'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                            ])
                                                      ]))
                                                ])));
                                          });
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}

class DetailsIcon {
  final String title;
  final IconData icon;

  DetailsIcon(this.title, this.icon);
}
