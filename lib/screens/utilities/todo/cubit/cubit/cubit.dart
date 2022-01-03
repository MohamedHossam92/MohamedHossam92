import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_smart_workshop/screens/utilities/todo/cubit/cubit/state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(InitState());

  String noteName = 'بدون اسم';
  String windowsTitle = 'بدون عنوان', windowsNote = '';

  void noteNameChanged(val) {
    noteName = val;
    emit(NoteNameChangedState());
  }

  void widowsDetails(int i, String val) {
    switch (i) {
      case 0:
        windowsTitle = val;
        break;

      case 2:
        windowsNote = val;
        break;
    }
    emit(WidowsDetailsState());
  }

  void clearData() {
    noteName = 'بدون اسم';
    windowsTitle = 'بدون اسم';
    windowsNote = '';
    emit(ClearDataState());
  }
}
