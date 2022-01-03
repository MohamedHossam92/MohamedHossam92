const String noteTableName = 'notes';
const String columnNoteId = 'noteId';
const String columnNoteTitle = 'noteTitle';

class NoteData {
  int? _noteId;
  String? _noteTitle;

  NoteData(dynamic obj) {
    _noteId = obj[columnNoteId];
    _noteTitle = obj[columnNoteTitle];
  }

  NoteData.fromMap(Map<String, dynamic> data) {
    _noteId = data[columnNoteId];
    _noteTitle = data[columnNoteTitle];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnNoteTitle: _noteTitle,
    };

    if (_noteId != null) map[columnNoteId] = _noteId;
    return map;
  }

  String? get clientName => _noteTitle;

  int? get clientId => _noteId;
}
