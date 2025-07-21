import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserModel {
  UserModel({this.email, this.password, this.uid});

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  final String? email;
  final String? password;
  final String? uid;

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  String toString() => 'UserModel(email: $email, uid: $uid)';

  Map<String, dynamic> toMap() => <String, dynamic>{'email': email, 'uid': uid};

  String toJson() => json.encode(toMap());

  bool get isValid => email != null && uid != null;

  Future<void> saveToSecureStorage() async {
    try {
      final data = toMap()..removeWhere((key, value) => value == null);
      final futures = data.entries.map((entry) {
        return _storage.write(key: entry.key, value: entry.value);
      });
      await Future.wait(futures);
      log('Dados salvos no SecureStorage com sucesso: $data');
    } catch (e) {
      log('Erro ao salvar no SecureStorage: $e');
    }
  }

  static Future<UserModel?> loadFromSecureStorage() async {
    try {
      final keys = UserModel.empty().toMap().keys.toList();
      final futures = keys.map((key) => _storage.read(key: key));
      final values = await Future.wait(futures);
      final data = Map<String, dynamic>.fromIterables(keys, values);
      if (data.values.every((value) => value == null)) {
        log('Nenhum dado encontrado no SecureStorage.');
        return null;
      }
      log('Dados carregados do SecureStorage: $data');
      return UserModel.fromMap(data);
    } catch (e, stackTrace) {
      log(
        'Erro ao carregar dados do SecureStorage: $e',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> deleteFromSecureStorage() async {
    try {
      final keys = toMap().keys;
      final futures = keys.map((key) => _storage.delete(key: key));
      await Future.wait(futures);
    } catch (e) {
      log('Erro ao deletar do SecureStorage: $e');
    }
  }

  bool get isValidLogin =>
      email != null &&
      email!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty;

  static UserModel empty() => UserModel(email: null, password: null, uid: null);
}
