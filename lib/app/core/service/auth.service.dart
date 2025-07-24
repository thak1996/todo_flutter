import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';
import 'package:todo_flutter/app/core/exceptions/general.exception.dart';
import 'package:todo_flutter/app/core/interfaces/auth.interface.dart';
import 'package:todo_flutter/app/core/models/user.model.dart';
import '../exceptions/auth.exception.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  AsyncResult<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.reload();

        final user = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
          name: userCredential.user!.displayName,
        );
        await user.saveToSecureStorage();
        return Success(user);
      } else {
        return Failure(
          GeneralException.unexpected('Falha ao criar usuário no Firebase'),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  AsyncResult<Unit> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Success(unit);
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
          name: userCredential.user!.displayName,
        );
        await user.saveToSecureStorage();
        return Success(user);
      } else {
        return Failure(
          GeneralException.unexpected(
            'Falha ao autenticar usuário no Firebase',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      return Failure(AuthException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> signOut() async {
    try {
      await _auth.signOut();
      return Success(unit);
    } catch (e) {
      return Failure(GeneralException.unexpected(e.toString()));
    }
  }
}
