// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class SendNotifications {
//   static final notifications = FlutterLocalNotificationsPlugin();
//   //مهمتها الاستماع إلي حدوث إشعار
//   static final onNotifications = BehaviorSubject<String?>();
//
//   static Future notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//           'channel id', 'channel name', 'channel description',
//           importance: Importance.max),
//       iOS: IOSNotificationDetails(),
//     );
//   }
//
//   //المسئولة عن عند الضغط علي الاشعار في القائمو المنسدلة
//   static Future init({bool initScheduled = false}) async {
//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final ios = IOSInitializationSettings();
//     final settings = InitializationSettings(android: android, iOS: ios);
//     await notifications.initialize(settings,
//         onSelectNotification: (payload) async {
//       onNotifications.add(payload);
//     });
//
//     if (initScheduled) {
//       tz.initializeTimeZones();
//       final locationName = await FlutterNativeTimezone.getLocalTimezone();
//     }
//   }
//
//   static Future showNotifications({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async =>
//       notifications.show(id, title, body, await notificationDetails(),
//           payload: payload);
//
//   static void showScheduledNotifications(
//           {int id = 0,
//           String? title,
//           String? body,
//           String? payload,
//           required DateTime scheduledDate}) async =>
//       notifications.zonedSchedule(
//           //سيتم ارسال الاشعار في الثامنة صباحاً
//           id,
//           title,
//           body,
//           scheduledDaily(Time(8)),
//           await notificationDetails(),
//           payload: payload,
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime,
//           matchDateTimeComponents: DateTimeComponents.time);
//
//   static tz.TZDateTime scheduledDaily(Time time) {
//     final now = tz.TZDateTime.now(tz.local);
//     final scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//       time.second,
//     );
//     return scheduledDate.isBefore(now)
//         ? scheduledDate.add(Duration(days: 1))
//         : scheduledDate;
//   }
// }
