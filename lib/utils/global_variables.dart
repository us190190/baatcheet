import 'package:flutter/material.dart';

class AppGlobalVariables extends ChangeNotifier {
  String userToken = "";

  void setUserToken(String token) {
    userToken = token;
    notifyListeners();
  }

  void resetUserToken() {
    userToken = "";
    notifyListeners();
  }
}
