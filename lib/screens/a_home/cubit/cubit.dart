import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';
import 'package:the_smart_workshop/screens/a_home/cubit/state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitState());
  int randomSlider = Random().nextInt(4) + 0;
  int randomButton = Random().nextInt(3) + 0;
  int itemIndex = 0;
  int? expansionIndex;
  int carouselSlider = 0;
  String callUsMessage = '';

  String askSupport = '', supportType = '', supportPhone = '';
  String guideName = '', guideType = '', guidePhone = '', guidePlace = '';
  String guideMessage = '';
  bool sendMessage = false;
  bool colorBackground = false;
  String? selectedColor;
  int guidePressedLength = 0;
  bool isPray = true;
  late SharedPreferences guidePrefs;
  late SharedPreferences prayStopPrefs;
  late SharedPreferences userTypePrefs;
  bool enterApp = false, downloadDeduct = false, isLoginIOS = false;

  late SharedPreferences downloadDeductPrefs, enterAppPrefs;

  Future<void> saveDownloadDeduct(bool state) async {
    downloadDeductPrefs = await SharedPreferences.getInstance();
    downloadDeductPrefs.setBool('downloadDeductPrefs', state);
    getDownloadDeductPrefs();
  }

  getDownloadDeductPrefs() async {
    downloadDeductPrefs = await SharedPreferences.getInstance();
    downloadDeduct =
        downloadDeductPrefs.getBool('downloadDeductPrefs') ?? downloadDeduct;
    emit(GetDownloadDeductPrefs());
  }

  Future<void> saveEnterApp(bool state) async {
    enterAppPrefs = await SharedPreferences.getInstance();
    enterAppPrefs.setBool('enterAppPrefs', state);
    await getEnterApp();
  }

  getEnterApp() async {
    enterAppPrefs = await SharedPreferences.getInstance();
    enterApp = enterAppPrefs.getBool('enterAppPrefs') ?? enterApp;
    emit(GetEnterApp());
  }

  AudioCache audioCache = AudioCache();

  int userType = -1;
  int getUserTypePrefs = -1;
  List<bool?> userState = [false, false, false];

  userStateChange(int i, bool? val) {
    userState.fillRange(0, userState.length, false);
    userState.replaceRange(i, i + 1, [true]);
    userType = i;

    emit(UserStateChange());
  }

  String country = 'egypt';
  int? countryGroupVal = 0;

  void countryGroupValChange(val) {
    countryGroupVal = val;
    if (val == 1) country = 'other';
    emit(CountryGroupValState());
  }

  int sureTechnical = -1;

  sureTechnicalChange(val) {
    sureTechnical = val;
    emit(SureTechnicalState());
  }

  downloadDeductChange() {
    downloadDeduct = true;
    emit(DownloadDeductState());
  }

  loginIOSChange() {
    isLoginIOS = true;
    emit(loginIOSState());
  }

  playPray() {
    if (isPray) {
      audioCache.play('audio/pray.mp3');
    }
  }

  void isPressedChanged(int i) {
    randomButton = i;
    emit(IsPressedChange());
  }

  void isCarouselSliderChanged(int i) {
    randomSlider = i;
    emit(IsCarouselSliderChange());
  }

  void itemIndexChanged(int i) {
    itemIndex = i;
    emit(ItemIndexChangedChange());
  }

  void expansionIndexChanged(int i) {
    expansionIndex == i ? expansionIndex = -1 : expansionIndex = i;
    emit(ExpansionIndexChangedState());
  }

  void callUsMessageChange(val) {
    callUsMessage = val;
    emit(CallUsMessageChangeState());
  }

  void selectedColorChange() {
    selectedColor = null;
    emit(SelectedColorChangeState());
  }

  void guideData(i, val) {
    switch (i) {
      case 0:
        guideName = val;
        break;
      case 1:
        guideType = val;
        break;

      case 2:
        guidePlace = val;
        break;
      case 3:
        guidePhone = val;
        break;
      case 4:
        guideMessage = val;
        break;
    }
    emit(GuideDataChangeState());
  }

  void sendMessageChanged() {
    sendMessage = !sendMessage;
    emit(SendMessageChangedState());
  }

  void supportTypeChanged(val, phone) {
    supportType = val;
    supportPhone = phone;
    emit(SupportTypeChangedState());
  }

  void askSupportChanged(val) {
    askSupport = val;
    emit(AskSupportChangedState());
  }

  void changeColorBackground(val) {
    colorBackground = val;
    emit(ChangeColorBackgroundState());
  }

  void selectedColorChanged(val) {
    selectedColor = val;
    emit(ChangeColorBackgroundState());
  }

  Future<void> saveGuidePressedLength(int id) async {
    guidePrefs = await SharedPreferences.getInstance();
    guidePrefs.setInt('guidePressedLength', id);
  }

  getId() async {
    guidePrefs = await SharedPreferences.getInstance();
    guidePressedLength =
        guidePrefs.getInt('guidePressedLength') ?? guidePressedLength;
    emit(GetGuidePressedLength());
  }

  Future<void> saveUserType(int id) async {
    userTypePrefs = await SharedPreferences.getInstance();
    userTypePrefs.setInt('userType', id);
    await getUserType();
  }

  getUserType() async {
    userTypePrefs = await SharedPreferences.getInstance();
    getUserTypePrefs = userTypePrefs.getInt('userType') ?? getUserTypePrefs;

    emit(GetUserType());
  }

  getPrayState() async {
    PrayPlay.prayStopPrefs = await SharedPreferences.getInstance();
    PrayPlay.isPray =
        PrayPlay.prayStopPrefs!.getBool('prayStopState') ?? PrayPlay.isPray;
    isPray = PrayPlay.isPray;
    emit(GetPrayState());
  }

  Future<void> savePrayStopState() async {
    isPray = !isPray;
    prayStopPrefs = await SharedPreferences.getInstance();
    prayStopPrefs.setBool('prayStopState', isPray);
  }

  initState(context) async {
    // SendNotifications.init(initScheduled: true);
    // listenNotifications(context);
    // SendNotifications.showScheduledNotifications(
    //     id: 0,
    //     title: 'تجربة',
    //     body: 'الحمد لله رب العالمين',
    //     payload: 'يي',
    //     scheduledDate: DateTime.now().add(Duration(seconds: 3)));

    await getId();
    await getUserType();
    await getPrayState();
    await getEnterApp();

    if (PrayPlay.isPray) audioCache.play('audio/pray.mp3');

    emit(InitStates());
  }
  //
  // //الاستماع إلي وجود إشعار
  // void listenNotifications(context) =>
  //     SendNotifications.onNotifications.stream.listen((event) {
  //       onClickNotification('dv', context);
  //     });
  //
  // //عند الضغط علي الاشعار
  // void onClickNotification(String? payload, context) async =>
  //     await Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => MyHomePage(payload: payload)));

  void incrementGuidePressedLength() {
    guidePressedLength++;
    saveGuidePressedLength(guidePressedLength);
    getId();

    emit(IncrementGuidePressedLength());
  }
}
