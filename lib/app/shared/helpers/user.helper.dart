import 'package:todo_flutter/app/core/models/user.model.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/exceptions/app.exception.dart';

class UserHelper {
  static Future<UserModel> getValidUser(AuthService authService) async {
    UserModel? user = await UserModel.loadFromSecureStorage();
    if (user == null || user.name == null || user.name!.isEmpty) {
      final firebaseUser = authService.currentUser;
      if (firebaseUser != null) {
        user = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
          photoUrl: firebaseUser.photoURL,
        );
        await user.saveToSecureStorage();
      } else {
        throw AppException.userNotFound();
      }
    }
    return user;
  }
}
