import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../../utils/size_config.dart';
import '../support_chat/support_chat.dart';

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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline_rounded,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
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
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/flat-design-illustration-customer-support_23-2148887720.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Text(
              'We are here to help so please get in touch with us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '+91 9649477393',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
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
            title: Text(
              'E-mail address',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'gitaman8481@gmail.com',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SupportChat(),
            ),
          );
        },
        child: Container(
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
                ),
              ),
            ),
            title: const Text(
              'Contact Live Chat',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              'We are ready to answer you',
              style: TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ),
    );
  }
}
