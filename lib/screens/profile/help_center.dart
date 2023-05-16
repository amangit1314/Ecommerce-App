import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../../utils/size_config.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        title: const Text(
          'Get Help',
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          // logout icon
          IconButton(
            onPressed: () {
              // logout
            },
            icon: const Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // container with decoration image
          Container(
            height: 200,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/payment.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Center(
            child: Text(
              'We are here to help so please get in touch with us',
              textAlign: TextAlign.center,
              // style of big bold font size with black color
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // size box h 20
          const SizedBox(
            height: 20,
          ),
          // tile with circular container contains phone icon with column have detail of phone number
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            title: Text('Phone Number'),
            subtitle: Text('+91 1234567890'),
          ),
          // divider with vertical padding of 20
          const Padding(
            padding: EdgeInsets.only(
              top: 2.0,
              bottom: 2.0,
              left: 15,
              right: 15,
            ),
            child: Divider(
              thickness: 1,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text('E-mail address'),
            subtitle: Text('gitaman8481@gmail.com'),
          ),

          // tile with square pic with little borderradius and column of contact live chat
        ],
      ),
      // bottom nav bar with littile
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(5),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
                child: FaIcon(
              FontAwesomeIcons.facebookMessenger,
              color: Colors.white,
            )),
          ),
          title: const Text('Contact Live Chat'),
          subtitle: const Text(
            'We are ready to answer you',
            // style with font siz e8
            style: TextStyle(fontSize: 12),
          ),
          // tailing icon of ios right arrow
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
