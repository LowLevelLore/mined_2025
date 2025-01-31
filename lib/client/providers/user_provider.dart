import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mined_2025/client/apis/crud_operations/crud_op.dart';
import 'package:mined_2025/client/apis/init/config.dart';
import 'package:mined_2025/client/models/user_model.dart';

class WebUserProvider extends ChangeNotifier {

  WebUser? user;

  void notify() {
    notifyListeners();
  }

  Future initUser() async {

    String? uid = Config.auth.currentUser?.uid;
    // log("#authId: $uid");
    if (uid != null) {
      user = WebUser.fromJson(await UserCrud.getUser(uid));
      // await NotificationApi.getFirebaseMessagingToken(uid);
    }
    notifyListeners();
    log("#initUser complete");
  }

  Future logOut() async {
    await Config.auth.signOut();
    user = null;
    notifyListeners();
  }


  bool isLoggedIn() {
    return user != null && Config.auth.currentUser != null;
  }


}