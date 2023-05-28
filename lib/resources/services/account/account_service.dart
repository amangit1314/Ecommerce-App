// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../models/models.dart';
// import '../../../providers/providers.dart';

// class AccountServices {
//   Future<List<Order>> fetchMyOrders({
//     required BuildContext context,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     List<Order> orderList = [];
//     try {
//       http.Response res =
//           await http.get(Uri.parse('$uri/api/orders/me'), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       });

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           for (int i = 0; i < jsonDecode(res.body).length; i++) {
//             orderList.add(
//               Order.fromJson(
//                 jsonEncode(
//                   jsonDecode(res.body)[i],
//                 ),
//               ),
//             );
//           }
//         },
//       );
//     } catch (e) {
//       GetSnackBar(
//         message: e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//     return orderList;
//   }

//   void logOut(BuildContext context) async {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       await sharedPreferences.setString('x-auth-token', '');
//       Navigator.push(
//         context,
//         Log,
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
// }
