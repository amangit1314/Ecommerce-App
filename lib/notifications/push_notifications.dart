import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soni_store_app/notifications/push_notification_response.dart';
import 'package:soni_store_app/notifications/recieve_notification.dart';
import 'package:soni_store_app/providers/auth_provider.dart';

import 'local_notifications.dart';

typedef PushNotificationSuccess = void Function();
typedef PushNotificationFailure = void Function(dynamic error);

const pushEvent = 'event';
const pushMessageReceived = 'pushMessageRecevied';

@pragma('vm:entry-point')
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  log('className: PushNotificationsManager');
  log('myBackgroundMessageHandler, data: ${message.data}, notification: ${message.notification?.body}');

  if (Platform.isAndroid) {
    var payload = message.data;
    payload['messageID'] = message.messageId;
    payload['appActive'] = false;
    payload['isTerminated'] = false;

    PushNotificationsManager._instance.sendLocalNotificationMessage(
      DateTime.now().microsecond,
      message.data['title'],
      message.data['body'],
      payload: jsonEncode(message.data),
    );
  } else {
    await PushNotificationsManager._instance.processNotificationMessage(
      message.data,
      message.messageId!,
      AuthProvider(),
      'myBackgroundMessageHandler',
    );
  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  FutureOr<String?> get token async => FirebaseMessaging.instance.getToken();

  void subscribeToChatRoom(String chatRoomId) {
    FirebaseMessaging.instance.subscribeToTopic(chatRoomId);
  }

  void unSubscribeToChatRoom(String chatRoomId) {
    FirebaseMessaging.instance.unsubscribeFromTopic(chatRoomId);
  }

  Future<void> init() async {
    FirebaseMessaging.instance.setAutoInitEnabled(false);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    NotificationSettings result =
        await FirebaseMessaging.instance.requestPermission();

    if (result.authorizationStatus == AuthorizationStatus.authorized) {
      _getInitialMessage();
      _onFirebaseMessageRecieved();
      _onBackgroundMessage();
      _onMessageOpenedApp();
    } else if (result.authorizationStatus == AuthorizationStatus.provisional) {
      log('className: $runtimeType');
      log('User granted provisional permission');
    } else {
      log('className: $runtimeType');
      log('text: Notifications already initialized');
    }
  }

  void _getInitialMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((event) async {
      if (Platform.isAndroid) {
        final notificationAppLaunchDetails =
            await LocalNotifications().getNotificationAppLaunchDetails();

        if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
          if (notificationAppLaunchDetails?.notificationResponse?.payload !=
              null) {
            parsePayloadToModel(
              notificationAppLaunchDetails!.notificationResponse!.payload!,
              terminated: true,
            );
          }
        }
      }

      if (event != null) {
        processNotificationMessage(
            event.data, event.messageId!, AuthProvider(), 'getInitialMessage');
      }
    });
  }

  void _onFirebaseMessageRecieved() {
    FirebaseMessaging.onMessage.listen((event) async {
      log('className: PushNotificationsManager');
      log('onMessage, event: ${event.data.toString()}');

      if (Platform.isAndroid) {
        sendLocalNotificationMessage(
          event.hashCode,
          event.data['title'],
          event.data['body'],
          payload: jsonEncode(event.data),
          notificationChannel: const NotificationChannel.messageReceived(),
        );
      }
    });
  }

  void _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      processNotificationMessage(
          event.data, event.messageId!, AuthProvider(), 'onMessageOpenedApp');
    });
  }

  void _onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  static Future<void> deleteToken() async {
    return FirebaseMessaging.instance.deleteToken();
  }

  static initNotification(
      {required PushNotificationSuccess success,
      required PushNotificationFailure failure}) {
    log('className: PushNotificationsManager');
    log('initNotification');
    PushNotificationsManager().init().then((value) {
      LocalNotifications().init(selectNotification).then((value) {
        success();
      });
    }).catchError((error) {
      failure(error);
    });
  }

  @pragma('vm:entry-point')
  static Future<dynamic> selectNotification(
      NotificationResponse? notificationResponse,
      {bool? isTerminated}) async {
    final notificationAppLaunchDetails =
        await LocalNotifications().getNotificationAppLaunchDetails();

    log('className: PushNotificationsManager');
    log(
      'selectNotification payload: ${notificationAppLaunchDetails?.notificationResponse?.payload?.toString()}',
    );

    if (notificationAppLaunchDetails?.didNotificationLaunchApp == true) {
      if (notificationAppLaunchDetails?.notificationResponse?.payload != null) {
        parsePayloadToModel(
            notificationAppLaunchDetails!.notificationResponse!.payload!);
      }
    } else {
      parsePayloadToModel(notificationResponse!.payload!);
    }
  }

  static PushNotificationResponse? parsePayloadToModel(dynamic payload,
      {bool terminated = false}) {
    PushNotificationResponse? pushData;
    try {
      final response = jsonDecode(payload);
      if (response.runtimeType == String) {
        pushData = PushNotificationResponse.fromJson(jsonDecode(
          response,
        ));
      } else {
        pushData = PushNotificationResponse.fromJson(
          response,
        );
      }

      // if (pushData.isTerminated != null && pushData.isTerminated! ||
      //     terminated) {
      //   BuildContext context = getIt<NavigationService>().navigationContext;
      //   final provider = Provider.of<NotificaitonState>(context, listen: false);
      //   provider.setPushNotificationResponse = pushData;
      //   provider.setMessageID = pushData.messageID;
      // } else {

      // }
      // LocalNotifications().cancelNotification(pushData.messageData);
    } catch (e) {
      log('className: PushNotificationsManager');
      log('selectNotification: $e');
    }

    return pushData;
  }

  Future<void> processNotificationMessage(
    dynamic payloadMap,
    String methodFrom,
    AuthProvider authProvider,
    String? messageID, {
    bool appActive = false,
  }) async {
    log('className: PushNotificationsManager');
    log('_processNotificationMessage, payloadMap: ${payloadMap?.toString()}, appActive: $appActive');
    final uid = authProvider.user.uid;

    if (uid.isNotEmpty) {
      try {
        if (methodFrom == 'myBackgroundMessageHandler' ||
            methodFrom == 'getInitialMessage') {
          RemoteMessage? terminatedMessage =
              await FirebaseMessaging.instance.getInitialMessage();

          if (terminatedMessage != null) {
            var payload = terminatedMessage.data;
            payload['messageID'] = messageID;
            payload['appActive'] = false;
            payload['isTerminated'] = true;

            PushNotificationsManager.selectNotification(
              NotificationResponse(
                notificationResponseType:
                    NotificationResponseType.selectedNotification,
                payload: jsonEncode(payload),
              ),
            );
          } else {
            var payload = payloadMap;
            payload['messageID'] = messageID;
            payload['appActive'] = false;
            payload['isTerminated'] = true;
            PushNotificationsManager.selectNotification(
              NotificationResponse(
                notificationResponseType:
                    NotificationResponseType.selectedNotification,
                payload: jsonEncode(payload),
              ),
            );
          }
        } else {
          var payload = payloadMap;
          payload['messageID'] = messageID;
          PushNotificationsManager.selectNotification(
            NotificationResponse(
              notificationResponseType:
                  NotificationResponseType.selectedNotification,
              payload: jsonEncode(payloadMap),
            ),
          );
        }
      } catch (e) {
        log('className: PushNotificationsManager');
        log('_processNotificationMessage, $e');
      }
    } else {
      log('className: PushNotificationsManager');
      log('_processNotificationMessage, NO UID FOUND, appActive: $appActive');
    }
  }

  Future sendLocalNotificationMessage(
    int id,
    String? title,
    String body, {
    String? imageUrl,
    String? payload,
    NotificationChannel notificationChannel =
        const NotificationChannel.general(),
  }) async {
    log('className: PushNotificationsManager');
    log(
      '_sendLocalNotificationMessage: , ' 'title: $title, body: $body',
    );

    LocalNotifications().showNotification(
      RecieveNotification(id, title, body, imageUrl, jsonEncode(payload)),
      notificationChannel: notificationChannel,
    );
  }
}

// Future writeLogs(String value) async {
//   final sharedPrefs = getIt<SharedPrefrenceHelper>();
//   final logs = await sharedPrefs.getLog();
//   await sharedPrefs.saveLog('$logs - $value');
// }