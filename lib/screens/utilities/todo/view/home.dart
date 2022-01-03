import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/component/const/padding.dart';
import 'package:the_smart_workshop/component/const/texts.dart';
import 'package:the_smart_workshop/component/widget/background.dart';
import 'package:the_smart_workshop/component/widget/snack_bar.dart';
import 'package:the_smart_workshop/component/widget/text_field.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/cubit.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/todo/model/note_title_data.dart';

import 'notes_detail.dart';

class ToDo extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(title: Text('نوتة مقاسات')),
                  body: AppBackGround(
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending_actions,
                          size: size.width * .3,
                        ),
                        BTextB5('خدمة نوتة المقاسات'),
                        DPadding(
                          child: BTextB4(
                              'لتنظيم عملية حفظ المقاسات وحساب المساحات'),
                        ),
                        BTextB4('وقريباً سيتم التخصيم مباشرة من هنا بإذن الله'),
                        Expanded(
                          child: DPadding(
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: cLogoColorW, width: 3),
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(
                                        size.width * .04)),
                                child: addNoteCubit.notesList.isEmpty
                                    ? SingleChildScrollView(child: NoNotes())
                                    : DPadding(
                                        val: .06,
                                        child: SingleChildScrollView(
                                          child: Column(
                                              children: addNoteCubit
                                                  .notesList.reversed
                                                  .map((e) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NoteDetails(
                                                              noteId: e[
                                                                  columnNoteId],
                                                              noteTitle: e[
                                                                  columnNoteTitle],
                                                            )));
                                              },
                                              child: Card(
                                                child: Row(
                                                  children: [
                                                    DPadding(
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            cLogoColor,
                                                        radius:
                                                            size.width * .055,
                                                        child: WTextB5(
                                                            e[columnNoteTitle]
                                                                .substring(
                                                                    0, 1)),
                                                      ),
                                                    ),
                                                    e[columnNoteTitle].length >=
                                                            19
                                                        ? BTextB5(
                                                            e[columnNoteTitle]
                                                                .substring(
                                                                    0, 19))
                                                        : BTextB5(
                                                            e[columnNoteTitle]),
                                                    Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  Dialog(
                                                                      child:
                                                                          Container(
                                                                    height:
                                                                        size.height *
                                                                            .33,
                                                                    child:
                                                                        Scaffold(
                                                                      appBar:
                                                                          AppBar(
                                                                        title: WTextB4(
                                                                            'أنت علي وشك حذف مقايسة'),
                                                                      ),
                                                                      body:
                                                                          Column(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.warning_rounded,
                                                                            size:
                                                                                size.width * .17,
                                                                            color:
                                                                                cLogoColorW,
                                                                          ),
                                                                          DPadding(
                                                                            child:
                                                                                BTextB4('قد تفقد كل البيانات التي قمت بإدخالها'),
                                                                          ),
                                                                          DPadding(
                                                                              child: BTextB4('فهل أنت متأكد من الحذف ؟')),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              MaterialButton(
                                                                                  color: Colors.black,
                                                                                  child: WTextB4('حذف'),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    addNoteCubit.deleteNotesDataFromDb(e[columnNoteId]);
                                                                                    addNoteCubit.deleteAllNotesDetailsDataFromDb(e[columnNoteId]);
                                                                                    ScaffoldMessenger.of(context).showSnackBar(dSnackBarShowResult(icon: Icons.done, title: 'تمت حذف ${e[columnNoteTitle]} بنجاح . '));
                                                                                  }),
                                                                              MaterialButton(
                                                                                  color: cLogoColorW,
                                                                                  child: WTextB4('انتظر'),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  }),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )));
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: cLogoColorW,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList()),
                                        ),
                                      )),
                          ),
                        ),
                        DPadding(
                          child: MaterialButton(
                              color: cLogoColorW,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [WTextB5('إضافة مقايسة جديدة')],
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState!
                                    .showBottomSheet((context) {
                                  return SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                size.width * .05),
                                            topLeft: Radius.circular(
                                                size.width * .05),
                                          ),
                                          color: cLogoColor,
                                        ),
                                        child: DPadding(
                                          val: .04,
                                          child: Center(
                                              child: WTextB5(
                                                  'إضافة مقايسة جديدة')),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * .003,
                                      ),
                                      DTextField(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'اسم المقايسة'),
                                          onChanged: (String? val) {
                                            noteCubit.noteNameChanged(val);
                                          },
                                        ),
                                      ),
                                      MaterialButton(
                                        child: WTextB5(
                                          'إضافة',
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);

                                          NoteData n = NoteData({
                                            columnNoteTitle: noteCubit.noteName
                                          });
                                          addNoteCubit.insertNoteToDb(n);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(dSnackBarShowResult(
                                                  icon: Icons.done,
                                                  title:
                                                      'تمت إضافة ${noteCubit.noteName} بنجاح . '));
                                          noteCubit.clearData();
                                        },
                                        color: cLogoColor,
                                      ),
                                    ],
                                  ));
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class NoNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.import_contacts,
          size: MediaQuery.of(context).size.width * .25,
          color: Colors.grey.shade400,
        ),
        BTextB4('لا يوجد مقايسات حتي الآن'),
        BTextB4('قم بإضافة مقايسة جديدة من الأسفل'),
      ],
    );
  }
}
