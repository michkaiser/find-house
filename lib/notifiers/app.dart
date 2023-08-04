import 'package:flutter/material.dart';


class AppNotifier with ChangeNotifier{
  bool isLoading = false;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }
}