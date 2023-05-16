import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late int counter;
  bool notificationsOnOrOff = false;

  @override
  void initState() {
    counter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading ios back arrow button
        leading: IconButton(
          onPressed: () {
            // back to previous screen
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
        title: const Text(
          'Notifications',
          // textstyle color kPrimaryColor
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      // if notifications are off show other scrren and if turn on then show body
      body: notificationsOnOrOff
          ? const NotificationsEnabledView()
          : const NotificationsDisabledVIew(),
    );
  }
}

class NotificationsEnabledView extends StatelessWidget {
  const NotificationsEnabledView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('turned on')),
      ],
    );
  }
}

class NotificationsDisabledVIew extends StatelessWidget {
  const NotificationsDisabledVIew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              image: AssetImage('assets/images/ringing_bell.png'),
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
                'Push notifications are currently turned off'
                // text align start
                ,
                textAlign: TextAlign.left,
                // textstyle color kPrimaryColor
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                'Enabling notifications allow us to send you info about their products, sales, events and more!'
                // text align start
                ,
                textAlign: TextAlign.left,
                // textstyle color kPrimaryColor
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            // enable notification button
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  // border radius

                  onPressed: () {},
                  // button color kPrimaryColor
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Enable Notifications',
                    // textstyle color kPrimaryColor
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
