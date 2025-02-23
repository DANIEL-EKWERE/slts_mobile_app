import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/models/auth/api_response_model.dart';
import 'package:slts_mobile_app/models/auth/token_model.dart';
import 'package:slts_mobile_app/services/auth_service.dart';
import 'package:slts_mobile_app/services/logger.dart';

TokenService get tokenService => Get.find();

class TokenService {
  Logger logger = Logger('TokenService');
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Rx<TokenModel> tokens = TokenModel().obs;
  RxString accessToken = ''.obs;
  // RxString refreshToken = ''.obs;

  static final TokenService _cache = TokenService._internal();

  factory TokenService() {
    return _cache;
  }

  TokenService._internal() {
    init();
  }

  void init() {
    logger.log('Initializing token service');
  }

  Future<bool> setTokenModel(tokensJson) async {
    tokens.value = TokenModel.fromJson(tokensJson);

    // come to this later #TODO:
    // await biometricService.saveTokensData(tokens.value);
    return true;
  }

  bool setAccessToken(token) {
    accessToken.value = token;
    return true;
  }

  // bool setRefreshToken(token) {
  //   refreshToken.value = token;
  //   return true;
  // }

  Future<bool> getNewAccessToken() async {
    try {
      final ApiResponseModel result = await authService.getNewAccessToken(
          // accessToken: accessToken.value
          );
      logger.log("refresh token: ${result.data} ${result.status}");

      if (result.status == 'success' || result.status_code == 200) {
        TokenModel tokenModel = TokenModel.fromJson(result.data);

        await saveTokensData(tokenModel);
        await setTokenModel(result.data);
        setAccessToken(result.data["accessToken"]);
        // tokenService.accessToken.value = result.data["accessToken"];
        return true;
      } else {
        logger.log("error fetching token");
        return false;
      }
    } catch (error) {
      logger.log("error getting refresh token ${error}");
      return false;
    }
  }

  // Tokens
  Future<void> saveTokensData(TokenModel token) async {
    logger.log('Saving token data');
    setAccessToken(token.token);
    String tokenJson = json.encode(token.toJson());
    await _secureStorage.write(key: 'auth_tokens', value: tokenJson);
  }

  Future<TokenModel?> getTokensData() async {
    logger.log('Getting token data');
    String? tokenJson = await _secureStorage.read(key: 'auth_tokens');
    if (tokenJson != null) {
      Map<String, dynamic> tokenModelMap = json.decode(tokenJson);
      return TokenModel.fromJson(tokenModelMap);
    }
    return null;
  }

  Future<void> deleteTokensData() async {
    logger.log('Deleting tokens data');
    await _secureStorage.delete(key: 'auth_tokens');
  }

  // Access Token
  Future<void> saveAccessToken(String token) async {
    logger.log('Saving Access token');
    await _secureStorage.write(key: 'auth_access_token', value: token);
  }

  Future<String?> getAccessToken() async {
    logger.log('Getting Access token');
    return await _secureStorage.read(key: 'auth_access_token');
  }

  Future<void> deleteAccessToken() async {
    logger.log('Deleting Access token');
    await _secureStorage.delete(key: 'auth_access_token');
  }

  Future<void> clearAll() async {
    logger.log('Deleting passcode');
    await _secureStorage.deleteAll();
    // await storageService.insert("firstTimeLogin", true);
  }
}
