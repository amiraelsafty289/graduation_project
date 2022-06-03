import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/data/firestore_utils.dart';
import 'package:flutter_blood_bank_app/data/user.dart' as AppUser;

class AuthProvider extends ChangeNotifier {
  AppUser.User? user = null;


  void updateUser(AppUser.User user) {
    this.user = user;
    notifyListeners();
  }

}