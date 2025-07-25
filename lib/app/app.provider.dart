import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/page/auth/register/register.controller.dart';
import 'package:todo_flutter/app/page/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    BlocProvider<LoginController>(
      create: (_) => LoginController(AuthService()),
    ),
    BlocProvider<HomeController>(create: (_) => HomeController(AuthService())),
    BlocProvider<RegisterController>(
      create: (_) => RegisterController(AuthService()),
    ),
  ];
}
