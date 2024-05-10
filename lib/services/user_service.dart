import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as getx;
import 'package:slts_mobile_app/models/user_model.dart';
import 'package:slts_mobile_app/services/logger.dart';

UserService get userService => getx.Get.find();

class UserService {
  Logger logger = Logger('UserService');
  // Rx<Agent> agentModel = Agent().obs;
  getx.Rx<UserModel> user = UserModel().obs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static final UserService _cache = UserService._internal();

  factory UserService() {
    return _cache;
  }

  UserService._internal() {
    init();
  }

  void init() {
    logger.log('Initializing User service');
  }


  bool setCurrentUser(userJson) {
    user.value = UserModel.fromJson(userJson);
    return true;
  }

  UserModel? getCurrentUser() {
    return user.value;
  }


// Persisting User Data in local storage
  Future<void> saveUserData(UserModel user) async {
    logger.log('Saving user data');
    String userJson = json.encode(user.toJson());
    await _secureStorage.write(key: 'user_data', value: userJson);
  }

  Future<void> saveData(String key, String value) async {
    logger.log('Saving value');
    await _secureStorage.write(key: key, value: value);
  }

  Future<dynamic> getData(String key) async {
    var value = await _secureStorage.read(key: key);
    return value;
  }

  Future<UserModel?> getUserData() async {
    logger.log('Getting user data');
    String? userJson = await _secureStorage.read(key: 'user_data');
    if (userJson != null) {
      Map<String, dynamic> userModelMap = json.decode(userJson);
      return UserModel.fromJson(userModelMap);
    }
    return null;
  }

  Future<void> deleteUserData() async {
    logger.log('Deleting user data');
    await _secureStorage.delete(key: 'user_data');
  }
}
