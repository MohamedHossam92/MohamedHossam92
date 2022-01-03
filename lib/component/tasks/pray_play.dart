import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayPlay {
  static bool isPray = true;

  static AudioCache audioCache = AudioCache();

  static playPray() {
    if (isPray) {
      audioCache.play('audio/pray.mp3');
    }
  }

  static SharedPreferences? prayStopPrefs;

  static Future<void> savePrayStopState() async {
    isPray = !isPray;

    prayStopPrefs = await SharedPreferences.getInstance();
    prayStopPrefs!.setBool('prayStopState', isPray);
  }
}
