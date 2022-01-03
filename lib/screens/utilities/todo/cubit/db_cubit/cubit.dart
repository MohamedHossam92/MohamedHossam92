import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/db_cubit/state.dart';
import 'package:the_smart_workshop/screens/utilities/todo/model/note_title_data.dart';
import 'package:the_smart_workshop/screens/utilities/todo/model/notes_details_data.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(InitState());
  List notesList = [];
  List notesDetailsList = [];

  late Database db;

  void createDb() {
    openDatabase('note.db', version: 1, onCreate: (db, v) {
      db
          .execute('CREATE TABLE $noteTableName (' +
              '$columnNoteId INTEGER PRIMARY KEY AUTOINCREMENT ,' +
              '$columnNoteTitle TEXT' +
              ')')
          .then((value) {});

      db
          .execute('CREATE TABLE $notesDetailsTableName (' +
              '$columnNoteDetailsId INTEGER PRIMARY KEY AUTOINCREMENT ,' +
              '$columnNotesId INTEGER,' +
              '$columnWindowsTitle TEXT,' +
              '$columnWindowsNote TEXT,' +
              '$columnWindowsWidth REAL,' +
              '$columnWindowsHeight REAL,' +
              '$columnWindowsLength INTEGER,' +
              '$columnWindowsPrice REAL,' +
              '$columnWindowsArea REAL,' +
              '$columnTotalPrice REAL,' +
              '$columnOncePrice REAL,' +
              '$columnTotalArea REAL' +
              ')')
          .then((value) {});
    }, onOpen: (db) {
      getNoteDataFromDb(db).then((value) {
        emit(GetNotesFromDb());
      });
      getNoteDetailDataFromDb(db).then((value) {
        emit(GetNotesDetailsFromDb());
      });
    }).then((value) {
      db = value;
      emit(NotesCreateDb());
    });
  }

  //===============insertData=================
  void insertNoteToDb(NoteData noteData) {
    db.insert(noteTableName, noteData.toMap()).then((value) {
      emit(GetInsertNotesDataToDb());
      getNoteDataFromDb(db).then((value) {
        emit(GetNotesFromDb());
      });
    });
  }

  void insertNoteDetailsToDb(NotesDetailsData notesDetailsData) {
    db.insert(notesDetailsTableName, notesDetailsData.toMap()).then((value) {
      emit(GetInsertNoteDetailsToDb());
      getNoteDetailDataFromDb(db).then((value) {
        emit(GetNotesDetailsFromDb());
      });
    });
  }

  //==================getData===============
  Future<List<Map>?> getNoteDataFromDb(db) async {
    return await db.query(noteTableName).then((value) {
      notesList = value;
      emit(GetNotesFromDb());
    });
  }

  Future<List<Map>?> getNoteDetailDataFromDb(db) async {
    return await db.query(notesDetailsTableName).then((value) {
      notesDetailsList = value;
      emit(GetNotesDetailsFromDb());
    });
  }

  //===================deleteData===================

  void deleteNotesDataFromDb(int id) {
    db.delete(noteTableName, where: '$columnNoteId = ?', whereArgs: [id]).then(
        (value) {
      getNoteDataFromDb(db);
      emit(DeleteDataFromDbToDb());
    });
  }

  void deleteOnceNotesDetailsDataFromDb(int id) {
    db.delete(notesDetailsTableName,
        where: '$columnNoteDetailsId = ?', whereArgs: [id]).then((value) {
      getNoteDetailDataFromDb(db);
      emit(DeleteOnceNotesDetailsDataFromDb());
    });
  }

  void deleteAllNotesDetailsDataFromDb(int id) {
    db.delete(notesDetailsTableName,
        where: '$columnNoteId = ?', whereArgs: [id]).then((value) {
      getNoteDetailDataFromDb(db);
      emit(DeleteAllNotesDetailsDataFromDb());
    });
  }
}
