import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/utils/log_printer.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  final Logger _logger = Logger(printer: LoggerPrinter('AuthNotifier'));

  Future<void> initialize() async {
    _isAuthenticated = await UserModel.areSavedDataValid();
    _logger.i('Auth initialized: $_isAuthenticated');
    notifyListeners();
  }

  Future<void> login() async {
    _isAuthenticated = true;
    _logger.i('User logged in: $_isAuthenticated');
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _logger.i('User logged out: $_isAuthenticated');
    notifyListeners();
  }
}
