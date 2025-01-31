

import 'package:mined_2025/client/apis/init/config.dart';

class UserCrud{


  static final _collectionRef = Config.firestore.collection("users");

  // get user by id
  static Future<dynamic> getUser(String userId) async {
    try {
      final docSnapshot = await _collectionRef.doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      return {
        "error": error.toString(),
        "stackTrace": stackTrace.toString(),
      };
    }
  }



}