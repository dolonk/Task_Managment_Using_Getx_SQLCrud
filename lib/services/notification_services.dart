import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart';
import 'package:get/get.dart';


var dtime;
class NotifyHelper {

  final _localNotificationservice = FlutterLocalNotificationsPlugin();

  // For Notification Set
  Future<void> notificationSettings() async {

    initializeTimeZones();

    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    //background state
     await _localNotificationservice.initialize(initializationSettings);

  }


  // For check Notification permission
  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await _localNotificationservice.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload: $payload");
        }
      }
    }
  }

  Future<NotificationDetails> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      '1',
      'ToDO app',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
    );

    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    Get.dialog(const Text('Welcome to fluttr'));
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _showNotification();
    await _localNotificationservice.show(id, title, body, details);
  }

  /*Future<void> scheduleNotification() async {
    final moonLanding = DateTime.parse(dtime);
    final details = await _showNotification();
    // ignore: deprecated_member_use
    await _localNotificationservice.showDailyAtTime(
      0,
      'Schedule Notification',
      'Thank you',
      Time(
        moonLanding.hour,
        moonLanding.minute,
        moonLanding.second,
      ),
      details,
    );
  }*/

  scheduledNotification() async {
    await _localNotificationservice.zonedSchedule(
        0,
        'scheduled title',
        'theme changes 5 seconds ago',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',
              importance: Importance.max,
              priority: Priority.max,)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

}
