
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BucketsProvider extends ChangeNotifier {
  bool isLoginEnabled = false ;

  void notify() {
    notifyListeners();
  }
}