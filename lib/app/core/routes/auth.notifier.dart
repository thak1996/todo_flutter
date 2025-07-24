import 'package:flutter/material.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> initialize() async {
    _isAuthenticated = await UserModel.areSavedDataValid();
    notifyListeners();
  }

  Future<void> login() async {
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
  }
}
