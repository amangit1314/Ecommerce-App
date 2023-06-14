import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/auth_provider.dart';

class SupportChat extends StatelessWidget {
  const SupportChat({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold with chat ui
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<AuthProvider>(builder: (context, authProvider, _) {
          return Tawk(
            directChatLink:
                'https://tawk.to/chat/647783acad80445890f04277/1h1pdkn04',
            visitor: TawkVisitor(
              name: authProvider.user.username ?? 'SnapCart User',
              email: authProvider.user.email,
            ),
            onLoad: () {
              log('Hello Tawk!');
            },
            onLinkTap: (String url) {
              log(url);
            },
            placeholder: const Center(
              child: Text('Loading...'),
            ),
          );
        }),
      ),
    );
  }
}

// support chat body for chat ui
// class Body extends StatelessWidget {
//   const Body({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: const [
//             // header with back btn and support agent name
//             Header(),
//             // chat messages
//             Messages(),
//             // chat input
//             ChatInput(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // header
// class Header extends StatelessWidget {
//   const Header({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           // back btn
//           IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           // support agent name
//           const Text(
//             'Support Agent',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // chat messages
// class Messages extends StatelessWidget {
//   const Messages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView(
//         children: const [
//           // chat message
//           ChatMessage(
//             message: 'Hello, how can I help you?',
//             isMe: false,
//           ),
//           // chat message
//           ChatMessage(
//             message: 'I need help with my order',
//             isMe: true,
//           ),
//           // chat message
//           ChatMessage(
//             message: 'Ok, I\'m here to help you',
//             isMe: false,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // chat input
// class ChatInput extends StatelessWidget {
//   const ChatInput({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         children: [
//           // input field
//           const Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Type a message',
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           // send btn
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// // chat message model
// class ChatMessage extends StatelessWidget {
//   const ChatMessage({
//     super.key,
//     required this.message,
//     required this.isMe,
//   });

//   final String message;
//   final bool isMe;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       child: Row(
//         mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           // chat message
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             decoration: BoxDecoration(
//               color: isMe ? kPrimaryColor : kSecondaryColor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Text(
//               message,
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
