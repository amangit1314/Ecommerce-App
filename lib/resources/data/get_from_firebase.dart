import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFetchMethods {
  static Future<Map<String, dynamic>> getFromFirebase(String path) async {
    Map<String, dynamic> data = {};
    await FirebaseFirestore.instance
        .collection(path)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        data = doc.data() as Map<String, dynamic>;
      }
    });
    return data;
  }
}
