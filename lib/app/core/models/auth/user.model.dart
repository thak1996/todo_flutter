import 'dart:convert';
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
    final data = toMap();
    final futures = data.entries
        .where((entry) => entry.value != null)
        .map((entry) => _storage.write(key: entry.key, value: entry.value));
    await Future.wait(futures);
  }

  static Future<UserModel?> loadFromSecureStorage() async {
    final keys = UserModel.empty().toMap().keys.toList();
    final futures = keys.map((key) => _storage.read(key: key));
    final values = await Future.wait(futures);

    final data = Map<String, dynamic>.fromIterables(keys, values);
    if (data.values.every((value) => value == null)) return null;

    return UserModel.fromMap(data);
  }

  Future<void> deleteFromSecureStorage() async {
    await Future.wait([
      _storage.delete(key: 'email'),
      _storage.delete(key: 'uid'),
    ]);
  }

  static UserModel empty() => UserModel(email: null, password: null, uid: null);
}
