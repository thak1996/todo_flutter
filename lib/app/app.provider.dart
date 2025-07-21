import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_flutter/app/page/home/home.controller.dart';
import 'page/auth/login/login.controller.dart';

class AppProvider {
  static List<SingleChildWidget> get providers => [
    BlocProvider<LoginController>(create: (_) => LoginController()),
    BlocProvider<HomeController>(create: (_) => HomeController()),
  ];
}
