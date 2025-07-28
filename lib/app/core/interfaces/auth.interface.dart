import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';

abstract class IAuthService {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  bool get isAuthenticated;

  AsyncResult<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  AsyncResult<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  AsyncResult<Unit> resetPassword(String email);
  AsyncResult<Unit> signOut();

  AsyncResult<UserModel> signInWithGoogle();
}
