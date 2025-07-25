import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:todo_flutter/app/core/utils/log_printer.dart';

class UserModel {
  UserModel({this.email, this.password, this.uid, this.name});

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
  final String? name;

  static final Logger _logger = Logger(printer: LoggerPrinter('UserModel'));
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  String toString() => 'UserModel(email: $email, uid: $uid, name: $name)';

  Map<String, dynamic> toMap() => <String, dynamic>{
    'email': email,
    'uid': uid,
    'name': name,
  };

  String toJson() => json.encode(toMap());

  bool get isValid => email != null && uid != null && name != null;

  bool get hasEssentialData =>
      email != null &&
      email!.isNotEmpty &&
      uid != null &&
      uid!.isNotEmpty &&
      name != null &&
      name!.isNotEmpty;

  Future<void> saveToSecureStorage() async {
    try {
      final data = toMap()..removeWhere((key, value) => value == null);
      final futures = data.entries.map((entry) {
        return _storage.write(key: entry.key, value: entry.value);
      });
      await Future.wait(futures);
      _logger.i('Dados salvos com sucesso.');
    } catch (e) {
      _logger.e('Erro ao salvar no SecureStorage: $e');
    }
  }

  static Future<UserModel?> loadFromSecureStorage() async {
    try {
      final data = await _readSecureStorage();
      if (data.values.every((value) => value == null)) {
        _logger.e('Nenhum dado encontrado.');
        return null;
      }
      _logger.i('Dados do usuário carregados');
      return UserModel.fromMap(data);
    } catch (e, stackTrace) {
      _logger.t(
        'Erro ao carregar dados do SecureStorage: $e',
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static Future<bool> areSavedDataValid() async {
    try {
      final data = await _readSecureStorage();
      final missingKeys = data.entries
          .where((entry) => entry.value == null || entry.value!.isEmpty)
          .map((entry) => entry.key)
          .toList();
      if (missingKeys.isNotEmpty) {
        _logger.w('Chaves inválidas ou ausentes: $missingKeys');
        return false;
      }
      _logger.i('Usuário válido, indo para a tela inicial.');
      return true;
    } catch (e) {
      _logger.e('Erro ao verificar dados salvos: $e');
      return false;
    }
  }

  Future<void> deleteFromSecureStorage() async {
    try {
      final keys = toMap().keys;
      final futures = keys.map((key) => _storage.delete(key: key));
      await Future.wait(futures);
    } catch (e) {
      _logger.e('Erro ao deletar do SecureStorage: $e');
    }
  }

  bool get isValidLogin =>
      email != null &&
      email!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty;

  bool get isValidRegister =>
      email != null &&
      email!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty &&
      name != null &&
      name!.isNotEmpty;

  static UserModel empty() =>
      UserModel(email: null, password: null, uid: null, name: null);

  UserModel copyWith({
    String? email,
    String? password,
    String? uid,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      name: name ?? this.name,
    );
  }

  static Future<Map<String, dynamic>> _readSecureStorage() async {
    final keys = UserModel.empty().toMap().keys.toList();
    final futures = keys.map((key) => _storage.read(key: key));
    final values = await Future.wait(futures);
    return Map<String, dynamic>.fromIterables(keys, values);
  }
}
