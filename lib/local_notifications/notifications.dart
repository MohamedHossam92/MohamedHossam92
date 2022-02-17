import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:the_smart_workshop/component/tasks/pray_play.dart';

class FlutterLocalNotificationHelper{

  static late AndroidInitializationSettings _initializationSettingsAndroid;
  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static late IOSInitializationSettings _initializationSettingsIOS;
  static late InitializationSettings _initializationSettings;

  static init(){
    _initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    _initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    _initializationSettings = InitializationSettings(android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(_initializationSettings,onSelectNotification: _onSelectNotification);
  }

  static Future _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}

  static Future<void> showNotification({String title = 'صلي علي محمد',String body= 'عليه افضل الصلاه والسلام',String payload = 'Payload'})async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.max, priority: Priority.high, showWhen: false,playSound: true, sound: RawResourceAndroidNotificationSound('pray'),);
    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(presentSound: true,presentAlert: true,presentBadge: true, sound: 'pray.mp3');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iosNotificationDetails);
    try{
      await _flutterLocalNotificationsPlugin.periodicallyShow(0, title, body, RepeatInterval.daily, platformChannelSpecifics, androidAllowWhileIdle: true);
      // await _flutterLocalNotificationsPlugin.show(
      //     0, title, body, platformChannelSpecifics,
      //     payload: 'item x').then((value) {
      // });
    }catch(e){}
  }

  static Future _onSelectNotification(String? payload) async {

  }
}