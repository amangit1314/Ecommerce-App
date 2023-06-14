// ignore_for_file: unused_field, unused_element

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late int counter;

  bool _notificationPermissionEnabled = false;

  @override
  void initState() {
    super.initState();
    counter = 0;
    _checkNotificationPermissionStatus();
  }

  void _checkNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    setState(() {
      _notificationPermissionEnabled = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(child: Text('$counter')),
            ),
          )
        ],
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
      ),
      body: _notificationPermissionEnabled
          ? const NotificationsEnabledView()
          : NotificationsDisabledView(
              notificationPermissionEnabled: _notificationPermissionEnabled,
            ),
    );
  }
}

class NotificationsEnabledView extends StatefulWidget {
  const NotificationsEnabledView({Key? key}) : super(key: key);

  @override
  State<NotificationsEnabledView> createState() =>
      _NotificationsEnabledViewState();
}

class _NotificationsEnabledViewState extends State<NotificationsEnabledView> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        notifications.add(message.notification?.body ?? '');
      });
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      setState(() {
        notifications.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Column(
        children: [
          Container(
            height: 300,
            margin: const EdgeInsets.only(
              top: 45,
              bottom: 5,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdni.iconscout.com/illustration/premium/thumb/no-notification-4790933-3989286.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15,
              bottom: 15,
            ),
            child: Text(
              'You have no notifications\nWhen you have any, we will notify you',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notifications[index]),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

class NotificationsDisabledView extends StatefulWidget {
  final bool notificationPermissionEnabled;
  const NotificationsDisabledView({
    super.key,
    required this.notificationPermissionEnabled,
  });

  @override
  State<NotificationsDisabledView> createState() =>
      _NotificationsDisabledViewState();
}

class _NotificationsDisabledViewState extends State<NotificationsDisabledView> {
  void _toggleNotificationPermission(bool notificationPermissionEnabled) async {
    if (!notificationPermissionEnabled) {
      final status = await Permission.notification.request();
      setState(() {
        notificationPermissionEnabled = status.isGranted;
      });
    } else {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 300,
          margin: const EdgeInsets.only(
            top: 45,
            bottom: 30,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/illustrationsAndSplash%2Fringing_bell.png?alt=media&token=0ea2ca3b-c78b-41ba-ae75-7e7de1128547'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
                bottom: 15,
              ),
              child: Text(
                'Push notifications are currently turned off',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                'Enabling notifications allow us to send you info about their products, sales, events and more!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _toggleNotificationPermission(
                    widget.notificationPermissionEnabled,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Enable Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
