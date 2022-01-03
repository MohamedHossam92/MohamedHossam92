const String notesDetailsTableName = 'notesDetails';
const String columnNotesId = 'noteId';
const String columnNoteDetailsId = 'noteDetailsId';
const String columnWindowsTitle = 'windowsTitle';
const String columnWindowsNote = 'windowsNote';
const String columnWindowsWidth = 'windowsWidth';
const String columnWindowsHeight = 'windowsHeight';
const String columnWindowsPrice = 'windowsPrice';
const String columnWindowsLength = 'windowsLength';
const String columnWindowsArea = 'windowsArea';
const String columnTotalPrice = 'windowsTotalPrice';
const String columnOncePrice = 'windowsOncePrice';
const String columnTotalArea = 'windowsTotalArea';

class NotesDetailsData {
  int? _noteId;
  int? _notesDetailsId;
  String? _windowsTitle, _windowsNote;
  double? _windowsWidth, _windowsHeight, _windowsPrice;
  int? _windowsLength;
  double? _windowsArea, _totalArea, _oncePrice, _totalPrice;

  NotesDetailsData(dynamic obj) {
    _noteId = obj[columnNotesId];
    _notesDetailsId = obj[columnNoteDetailsId];
    _windowsTitle = obj[columnWindowsTitle];
    _windowsNote = obj[columnWindowsNote];
    _windowsWidth = obj[columnWindowsWidth];
    _windowsHeight = obj[columnWindowsHeight];
    _windowsPrice = obj[columnWindowsPrice];
    _windowsLength = obj[columnWindowsLength];
    _windowsArea = obj[columnWindowsArea];
    _totalArea = obj[columnTotalPrice];
    _totalPrice = obj[columnTotalArea];
    _oncePrice = obj[columnOncePrice];
  }

  NotesDetailsData.fromMap(Map<String, dynamic> data) {
    _noteId = data[columnNotesId];
    _notesDetailsId = data[columnNoteDetailsId];
    _windowsTitle = data[columnWindowsTitle];
    _windowsNote = data[columnWindowsNote];
    _windowsWidth = data[columnWindowsWidth];
    _windowsHeight = data[columnWindowsHeight];
    _windowsPrice = data[columnWindowsPrice];
    _windowsLength = data[columnWindowsLength];
    _windowsArea = data[columnWindowsArea];
    _totalArea = data[columnTotalPrice];
    _totalPrice = data[columnTotalArea];
    _oncePrice = data[columnOncePrice];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnNoteDetailsId: _notesDetailsId,
      columnNotesId: _noteId,
      columnWindowsTitle: _windowsTitle,
      columnWindowsNote: _windowsNote,
      columnWindowsWidth: _windowsWidth,
      columnWindowsHeight: _windowsHeight,
      columnWindowsPrice: _windowsPrice,
      columnWindowsLength: _windowsLength,
      columnWindowsArea: _windowsArea,
      columnTotalPrice: _totalArea,
      columnTotalArea: _totalPrice,
      columnOncePrice: _oncePrice,
    };

    return map;
  }

  int? get windowsLength => _windowsLength;

  double? get windowsPrice => _windowsPrice;

  double? get windowsHeight => _windowsHeight;

  double? get windowsWidth => _windowsWidth;

  String? get windowsNote => _windowsNote;

  String? get windowsTitle => _windowsTitle;

  int? get notesDetailsId => _notesDetailsId;

  int? get noteId => _noteId;

  double? get totalPrice => _totalPrice;

  double? get totalArea => _totalArea;

  double? get windowsArea => _windowsArea;

  double? get oncePrice => _oncePrice;
}
