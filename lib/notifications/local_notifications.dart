// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soni_store_app/notifications/push_notification_response.dart';
import 'package:soni_store_app/notifications/recieve_notification.dart';

const String applicationName = "SnapCart";
const String generalCategory = "Products";
const String socialCategory = "Social";
const String dealsCategory = "Deals";
const String featuresCategory = "Features";
const String fashionCategory = "Fashion";

class LocalNotifications {
  static final LocalNotifications _localNotifications =
      LocalNotifications._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory LocalNotifications() {
    return _localNotifications;
  }

  LocalNotifications._internal();

  late AndroidInitializationSettings initializationSettingsAndroid;
  late DarwinInitializationSettings iosInitializationSettings;
  late InitializationSettings initializationSettings;

  Future<void> init(selectNotification) async {
    var androidSpcImp =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!;
    getCheckOrGetNotificationPermission(androidSpcImp);
    androidSpcImp.createNotificationChannel(createAndroidNotificationChannel());
    // log runtime type using log of dart:developer
    log('androidSpcImp: ${androidSpcImp.runtimeType}');

    initizePlatformSettings();
    bool? initialised = await initizePlugin(selectNotification);
    log('androidSpcImp: ${androidSpcImp.runtimeType}');
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    log('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  didRecieveNotification(NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      PushNotificationResponse pushData;
      try {
        final response = jsonDecode(notificationResponse.payload!.toString());
        if (response.runtimeType == String) {
          pushData = PushNotificationResponse.fromJson(jsonDecode(
            response,
          ));
        } else {
          pushData = PushNotificationResponse.fromJson(
            response,
          );
        }

        switch (pushData.eventType) {
          case 'Products':
            return '';
          case 'Deals':
            return '';
          default:
            break;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  AndroidNotificationChannel createAndroidNotificationChannel() {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      '57442',
      'Tempo General Notification',
      description: 'Notifications when tempo wants to communicate with you',
      importance: Importance.max,
    );

    return channel;
  }

  void showNotification(RecieveNotification message,
      {NotificationChannel notificationChannel =
          const NotificationChannel.general()}) async {
    /***
       * 
       * Logger
       * 
    ****/
    log('className: $runtimeType');
    log('showNotification notificationMessage: ${message.title} || body: ${message.body}');

    /***
       * 
       * show notification impl
       * 
    ***/

    NotificationDetails? notificationDetails =
        await getPlatformChannelSpecifics(
            message, '', 'thread_id', notificationChannel);

    await flutterLocalNotificationsPlugin.show(
      message.id.hashCode,
      message.title ?? applicationName,
      message.body,
      notificationDetails,
      payload: message.payload,
    );
  }

  Future<NotificationDetails?> getPlatformChannelSpecifics(
    RecieveNotification message,
    String iosSubTitle,
    String threadIdentifier,
    NotificationChannel channel,
  ) async {
    try {
      // final String largeIcon = await _base64EncodedImage(message.imageUrl ?? '');
      String bigPicture = '';
      if (message.imageUrl != null) {
        bigPicture = await _base64EncodedImage(message.imageUrl ?? '');
      }

      BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(bigPicture),
      );

      return NotificationDetails(
        iOS: _darwinNotificationDetails(iosSubTitle, threadIdentifier, channel),
        android: _androidNotificationDetails(
          channel,
          bigPicture.isNotEmpty ? bigPictureStyleInformation : null,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  DarwinNotificationDetails _darwinNotificationDetails(String iosSubTitle,
      String threadIdentifier, NotificationChannel channel) {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
  }

  Future<String> _base64EncodedImage(String url) async {
    final response = await Dio().get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    final String base64Data = base64Encode(response.data ?? []);
    return base64Data;
  }

  AndroidNotificationDetails _androidNotificationDetails(
      NotificationChannel channel, StyleInformation? styleInformation) {
    return AndroidNotificationDetails(
      channel.channelId,
      channel.channelName,
      channelDescription: channel.channelDescription,
      category: AndroidNotificationCategory.message,
      priority: channel.priority,
      importance: channel.importance,
      channelShowBadge: true,
      playSound: true,
      icon: 'res_notification_tempo_icon',
      styleInformation: styleInformation,
      showProgress: true,
      ticker: 'Tempo',
    );
  }

  void cancelNotification(String payload) async {
    log('className: $runtimeType');
    log('cancelNotification payload: $payload');
    await flutterLocalNotificationsPlugin.cancel(payload.hashCode);
  }

  Future<NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() async {
    log('className: $runtimeType');
    log('getNotificationAppLaunchDetails');
    return await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  void cancelAllNotifications() async {
    log('className: $runtimeType');
    log('cancleAllNotifications');
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void handleApplicationWasLaunchedFromNotification() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    log('className: $runtimeType');
    log('handleApplicationWasLaunchedFromNotification : ${notificationAppLaunchDetails?.notificationResponse?.payload} --> '
        '${notificationAppLaunchDetails?.didNotificationLaunchApp}');

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      log('className: $runtimeType');
      log('handleApplicationWasLaunchedFromNotification cancelling');
      cancelNotification(
          notificationAppLaunchDetails.notificationResponse!.payload!);
    }
  }

  getCheckOrGetNotificationPermission(
      AndroidFlutterLocalNotificationsPlugin androidSpcImp) async {
    bool? notificationPermission =
        await androidSpcImp.areNotificationsEnabled();
    if (notificationPermission!) androidSpcImp.requestPermission();
  }

  initizePlatformSettings() {
    initializationSettingsAndroid =
        const AndroidInitializationSettings('res_notification_tempo_icon');
    iosInitializationSettings = const DarwinInitializationSettings();
    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSettings,
    );
  }

  Future<bool?> initizePlugin(selectNotification) async {
    return await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );
  }
}

class NotificationChannel {
  final String channelId;
  final String channelName;
  final String channelDescription;
  final Importance importance;
  final Priority priority;
  final String category;

  const NotificationChannel.general()
      : channelId = '123123',
        channelName = 'Tempo General Notification',
        channelDescription =
            'Notifications when tempo wants to communicate with you',
        importance = Importance.defaultImportance,
        category = generalCategory,
        priority = Priority.defaultPriority;

  const NotificationChannel.messageReceived()
      : channelId = '123123',
        channelName = 'Messages Notification',
        channelDescription = 'Notifications when someone texts you',
        importance = Importance.defaultImportance,
        category = socialCategory,
        priority = Priority.high;
}
