import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:slts_mobile_app/models/auth/api_response_model.dart';
import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/services/dio_class.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/services/token_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';
import 'package:slts_mobile_app/utils/utils.dart';
import '../models/user_model.dart';
import 'logger.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:slts_mobile_app/models/violations/add_violations.dart';

ApiService get apiService => getx.Get.find();

class ApiService {
  Logger logger = Logger('ApiService');
  final String baseURL = AppStrings.baseURL;
  late final Dio _dio;
  static final client = http.Client();
  RxList<AddViolations> violationList = RxList<AddViolations>();
  var violationLists = <Violation>[].obs;
  static final ApiService _cache = ApiService._internal();

  factory ApiService() {
    return _cache;
  }

  ApiService._internal() {
    init();
  }

  Future<void> init() async {
    logger.log("Initializing Dio");

    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (int? status) {
          return status != null;
          // return status != null && status >= 200 && status < 300;
        },
      ),
    );

    _dio.interceptors.addAll([
      // ErrorInterceptor(),
      InterceptorsWrapper(onRequest: (options, handler) {
        // Add the access token to the request header
        logger.log("request token:: ${tokenService.accessToken.value}");

        options.headers['Authorization'] =
            'Bearer ${tokenService.accessToken.value}';
        return handler.next(options);
      }, onError: (DioException e, handler) {
        if (kDebugMode) {
          print("app error data $e");
        }
        ErrorEntity eInfo = createErrorEntity(e);
        onError(eInfo);
      }),
    ]);
    logger.log("Dio initialization completed");
  }

  Options get options {
    return Options(
      headers: {
        // 'Authorization': 'Bearer $token',
      },
    );
  }

  Future<dynamic> post({
    required body,
    required String endpoint,
    // required BuildContext context,
    String token = '',
  }) async {
    try {
      logger.log("POST REQUEST DATA:: $baseURL  $endpoint $body");

      var response = await client.post(
        Uri.parse("$baseURL$endpoint"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      logger.log("response 2:: ${response.body}");
      logger.log("response 2:: ${response.statusCode}");
      return {
        'reqMessage': 'successful',
        'reqSuccess': true,
        'reqResponse': response.body,
      };
    } on SocketException {
      return {
        'reqMessage': 'No Internet connection 😑',
        'reqSuccess': false,
      };
    } on HttpException {
      return {
        'reqMessage': "Couldn't find the post 😱",
        'reqSuccess': false,
      };
    } on FormatException {
      return {
        'reqMessage': "Bad response format 👎",
        'reqSuccess': false,
      };
    }
  }

  // TODO: Start here

  Future<dynamic> getViolations({
    // required BuildContext context,
    String? token,
  }) async {
    try {
      logger.log("GET REQUEST DATA:: INITIALIZING...");
      String? tenantId = await getUserData1();
      var response = await client.get(
        Uri.parse("$baseURL/$tenantId/violations"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer  ${token ?? tokenService.accessToken.value}",
        },
      );

      // logger.log("response 2:: ${response.body}");
      // logger.log("response 2:: ${response.statusCode}");
      var result = jsonDecode(response.body);
      //  logger.log("GET REQUEST DATA:: INITIALIZING... ${result['violations']}");

      for (var x in result['violations']) {
        violationList.add(AddViolations.fromMap(x));
        logger.log("GET REQUEST DATA:: INITIALIZING... $x");
      }
      var x = (violationsModelFromJson(response.body).violations);
      if (x != null) {
        violationLists.value = x;
      }
      logger.log(
          ";;;;;;; ${violationsModelFromJson(response.body).violations![0]};;;;;;;;;;;;;;");
      return {
        'reqMessage': 'successful',
        'reqSuccess': true,
        'reqResponse': response.body,
      };
    } on SocketException {
      return {
        'reqMessage': 'No Internet connection 😑',
        'reqSuccess': false,
      };
    } on HttpException {
      return {
        'reqMessage': "Couldn't find the post 😱",
        'reqSuccess': false,
      };
    } on FormatException {
      return {
        'reqMessage': "Bad response format 👎",
        'reqSuccess': false,
      };
    }
  }

  // TODO: ends here

  Future<String> getUserData1() async {
    try {
      UserModel? user = await userService.getUserData();
      if (user != null) {
        return '${user.tenant!.id}';
      } else {
        return '';
      }
    } catch (e) {
      logger.log("POST VIOLATIONS REQUEST DATA SUCCEEDED:: $e ");
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: '$e', color: red);
    }
    return '';
  }

  Future<dynamic> postViolation1({
    //   required String location,
    // required String phone,
    // required String state,
    // required String recommended_by,
    // File? profile_picture

    required body,
    required String endpoint,
  }) async {
    String? tenantId = await getUserData1();
    print('calling the postViolation method');
    String url = '$baseURL/$tenantId/violations';
    String? token;

    Map<String, String>? reqHeader = {
      "Accept": "multipart/form-data",
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${token ?? tokenService.accessToken.value}',
    };
    //  _reqMessage = 'access token $access';

    try {
      var res = http.MultipartRequest('POST', Uri.parse(url));

      // Set the headers
      res.headers.addAll(reqHeader);

      res.fields['violationLocation'] = body.location;
      // added some fields here
      res.fields['vin'] = body.vin;
      res.fields['violationCode'] = body.violationCode;
      res.fields['fine'] = body.fine;
      //res.fields['vehicleType'] = body.vehicleType;
      res.fields['vehicleType'] = body.vehicleType;
      res.fields['vehicleMake'] = body.vehicleMake;
      res.fields['vehicleYear'] = body.vehicleYear;
      res.fields['firstName'] = body.firstName;
      res.fields['lastName'] = body.lastName;
      res.fields['gender'] = body.gender;
      res.fields['creator'] = body.creator;
      res.fields['violation'] = body.violation;

      res.fields['plateNumber'] = body.plateNumber;
      //res.fields['violationType'] = body.violationType;
      //res.fields['comment'] = body.comment;

      final pickedFileToFile = File(File(body.evidences[0]).path);
      //  print(pickedFileToFile);
      final imageStream =
          http.ByteStream(Stream.castFrom(pickedFileToFile.openRead()));
      final lenght = await pickedFileToFile.length();
      final imageUpload = http.MultipartFile(
          'profile_picture', imageStream, lenght,
          filename: basename(pickedFileToFile.path));

      final pickedFileToFile1 = File(File(body.carPhotos[1]).path);
      //  print(pickedFileToFile);
      final imageStream1 =
          http.ByteStream(Stream.castFrom(pickedFileToFile1.openRead()));
      final lenght1 = await pickedFileToFile.length();
      final imageUpload1 = http.MultipartFile(
          'profile_picture1', imageStream1, lenght1,
          filename: basename(pickedFileToFile1.path));

      final pickedFileToFile2 = File(File(body.carPhotos[2]).path);
      //  print(pickedFileToFile);
      final imageStream2 =
          http.ByteStream(Stream.castFrom(pickedFileToFile2.openRead()));
      final lenght2 = await pickedFileToFile.length();
      final imageUpload2 = http.MultipartFile(
          'profile_picture2', imageStream2, lenght2,
          filename: basename(pickedFileToFile2.path));

      res.files.add(imageUpload);
      // res.files.add(imageUpload1);
      // res.files.add(imageUpload2);
      var response = await res.send();
      if (response.statusCode == 201 || response.statusCode == 200) {
        showSuccessSnackbar(
            snackPosition: SnackPosition.TOP,
            message: 'violation uploaded successfully',
            color: green);
        logger.log(
            "POST VIOLATIONS REQUEST DATA SUCCEEDED:: ${response.statusCode} ");
      } else if (response.statusCode == 500) {
        var req = await response.stream.bytesToString();
        var res = json.decode(req);
        var message = res['description'];
        showSuccessSnackbar(
            snackPosition: SnackPosition.TOP, message: message, color: red);
        logger.log(
            "POST VIOLATIONS REQUEST DATA FAILED:: $message ${response.statusCode} ${req}");
      } else if (response.statusCode == 401) {
        var req = await response.stream.bytesToString();
        var res = json.decode(req);
        var message = res['message'];
        logger.log(
            "POST VIOLATIONS REQUEST DATA FAILED:: $message ${response.statusCode}");
        // Handle unauthorized access (e.g., redirect to login screen)
        // Example: Navigator.pushNamed(context, '/login');
        //  Navigator.of(context!)
        //     .pushNamedAndRemoveUntil("/Login", (route) => false);
      } else {
        var responseBody = await response.stream.bytesToString();
        var responseJson = json.decode(responseBody);

        // Check if 'body' property exists in the response
        var bodyValue = responseJson['body'] ?? 'No body found';

        print('Error Creating Profile ${response.statusCode} $bodyValue');
      }
    } on SocketException catch (_) {
      logger.log("POST VIOLATIONS REQUEST DATA FAILED:: $_ socket exception");
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: '$_', color: red);
    } catch (e) {
      logger.log("POST VIOLATIONS REQUEST DATA FAILED EXCEPTION:: $e");
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: '$e', color: red);
    }
  }

//TODO:::::::::::::::::::::::::

  Future<dynamic> postViolations2({
    required dynamic violationLocation,
    required dynamic vin,
    required dynamic fine,
    required dynamic vehicleType,
    required dynamic vehicleMake,
    required dynamic vehicleYear,
    required dynamic firstName,
    required dynamic lastName,
    required dynamic gender,
    required dynamic creator,
    required dynamic violation,
    required dynamic plateNumber,
    required dynamic violationCode,
    required RxList<String>? evidences,
  }) async {
    FormData formData = FormData.fromMap({
      'violationLoaction': violationLocation,
      'vin': vin,
      'violationCode': violationCode,
      'fine': fine,
      'vehicleType': vehicleType,
      'vehicleMake': vehicleMake,
      'vehicleYear': vehicleYear,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'creator': creator,
      'violation': violation,
      'plateNumber': plateNumber,
    });

    for (var file in evidences!) {
      formData.files.addAll(
          [MapEntry('evidences[]', await MultipartFile.fromFile(file))]);
    }
    print(formData.toString());
    try {
      logger.log("POSTING VIOLATIONS:::::::::::::::: in tr block");
      late Response response;
      String? tenantId = await getUserData1();
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'calling the postViolation method',
          color: red);
      String endpoint = '$baseURL/$tenantId/violations';
      String? token;
      _dio.options.connectTimeout =const Duration(milliseconds: 20000);
      response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer ${token ?? tokenService.accessToken.value}',
          },
        ),
      );
      logger.log("POST REQUEST RESPONSE:: $response ${response.statusCode}");

      if (response.statusCode == 200) {
        showSuccessSnackbar(
            snackPosition: SnackPosition.TOP,
            message: 'post successful',
            color: green);
      } else {
        logger.log("POST REQUEST RESPONSE:: $response ${response.statusCode}");
      }
    } on DioException catch (e) {
      logger.log("POST REQUEST ERROR ($e) :: ${e.response?.data}");
      // checkException(e);
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: '$e ${e.response?.data}',
          color: red);
      if (e.response?.data != null) {
        return e.response?.data;
      }
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'an error occured',
          color: red);
      throw "An error occurred";
    } on SocketException {
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'seems your offline',
          color: red);
      throw "seems you are offline";
    } catch (error) {
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: error.toString(),
          color: red);
      throw error.toString();
    }
  }


  Future<dynamic> putViolations({
    required dynamic violationLocation,
    required dynamic vin,
    required dynamic fine,
    required dynamic vehicleType,
    required dynamic vehicleMake,
    required dynamic vehicleYear,
    required dynamic firstName,
    required dynamic lastName,
    required dynamic gender,
    required dynamic creator,
    required dynamic violation,
    required dynamic plateNumber,
    required dynamic violationCode,
  }) async {
    FormData formData = FormData.fromMap({
      'violationLoaction': violationLocation,
      'vin': vin,
      'violationCode': violationCode,
      'fine': fine,
      'vehicleType': vehicleType,
      'vehicleMake': vehicleMake,
      'vehicleYear': vehicleYear,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'creator': creator,
      'violation': violation,
      'plateNumber': plateNumber,
    });

    try {
      logger.log("PUTING VIOLATIONS:::::::::::::::: in try block");
      late Response response;
      String? tenantId = await getUserData1();
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'calling the postViolation method',
          color: red);
      String endpoint = '$baseURL/$tenantId/violations';
      String? token;
      _dio.options.connectTimeout =const Duration(milliseconds: 20000);
      response = await _dio.put(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer ${token ?? tokenService.accessToken.value}',
          },
        ),
      );
      logger.log("PUT REQUEST RESPONSE:: $response ${response.statusCode}");

      if (response.statusCode == 200) {
        showSuccessSnackbar(
            snackPosition: SnackPosition.TOP,
            message: 'post successful',
            color: green);
      } else {
        logger.log("POST REQUEST RESPONSE:: $response ${response.statusCode}");
      }
    } on DioException catch (e) {
      logger.log("POST REQUEST ERROR ($e) :: ${e.response?.data}");
      // checkException(e);
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: '$e ${e.response?.data}',
          color: red);
      if (e.response?.data != null) {
        return e.response?.data;
      }
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'an error occured',
          color: red);
      throw "An error occurred";
    } on SocketException {
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: 'seems your offline',
          color: red);
      throw "seems you are offline";
    } catch (error) {
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP,
          message: error.toString(),
          color: red);
      throw error.toString();
    }
  }

  Future<void> postViolation({
    required Map<String, dynamic> body,
    required String endpoint,
  }) async {
    try {
      String? tenantId = await getUserData1();
      String url = '$baseURL/$tenantId/violations';
      String? token = tokenService.accessToken.value;

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer $token';

      // Add fields to the request
      body.forEach((key, body) {
        //   request.fields[key] = value.toString();

        request.fields['violationLocation'] = body.location;
        // added some fields here
        request.fields['vin'] = body.vin;
        request.fields['violationCode'] = body.violationCode;
        request.fields['fine'] = body.fine;
        //res.fields['vehicleType'] = body.vehicleType;
        request.fields['vehicleType'] = body.vehicleType;
        request.fields['vehicleMake'] = body.vehicleMake;
        request.fields['vehicleYear'] = body.vehicleYear;
        request.fields['firstName'] = body.firstName;
        request.fields['lastName'] = body.lastName;
        request.fields['gender'] = body.gender;
        request.fields['creator'] = body.creator;
        request.fields['violation'] = body.violation;

        request.fields['plateNumber'] = body.plateNumber;
      });

      // Add images as files to the request
      for (int i = 0; i < body['evidences'].length; i++) {
        String imagePath = body['evidences'][i];
        File imageFile = File(imagePath);
        String fileName = imageFile.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath(
          'evidences',
          imageFile.path,
          filename: fileName,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Violation uploaded successfully');
      } else {
        var responseBody = await response.stream.bytesToString();
        var responseJson = json.decode(responseBody);
        var message = responseJson['description'];
        logger.log("POST VIOLATIONS REQUEST DATA FAILED:: $message");
        showSuccessSnackbar(
            snackPosition: SnackPosition.TOP, message: message, color: red);
      }
    } on SocketException catch (_) {
      logger.log("POST VIOLATIONS REQUEST DATA FAILED:: $_ socket exception");
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: '$_', color: red);
    } catch (e) {
      logger.log("POST VIOLATIONS REQUEST DATA FAILED EXCEPTION:: $e");
      showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: '$e', color: red);
    }
  }

  Future<dynamic> postViolations({
    required body,
    required String endpoint,
    // required BuildContext context,
    String token = '',
  }) async {
    try {
      logger.log("POST VIOLATIONS REQUEST DATA:: $baseURL  $endpoint $body");

      var response = await client.post(
        Uri.parse("$baseURL$endpoint"),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      logger.log("response 2:: ${response.body}");
      logger.log("response 2:: ${response.statusCode}");
      return {
        'reqMessage': 'successful',
        'reqSuccess': true,
        'reqResponse': response.body,
      };
    } on SocketException {
      return {
        'reqMessage': 'No Internet connection 😑',
        'reqSuccess': false,
      };
    } on HttpException {
      return {
        'reqMessage': "Couldn't find the post 😱",
        'reqSuccess': false,
      };
    } on FormatException {
      return {
        'reqMessage': "Bad response format 👎",
        'reqSuccess': false,
      };
    }
  }

  Future<dynamic> postRequest({
    required String endpoint,
    Map? data,
    String? token,
  }) async {
    try {
      logger.log("POST REQUEST DATA:: $baseURL  $endpoint $data");
      late Response response;
      response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${token ?? tokenService.accessToken.value}',
          },
        ),
      );
      logger.log("POST REQUEST RESPONSE:: $response");
      final ApiResponseModel apiResponse =
          ApiResponseModel.fromJson(response.data);
      if (!endpoint.contains('auth')) {
        if (apiResponse.status_code == 400) {
          // if refresh token returns invalid token, log the user out
          bool newAccessTokenResult = await tokenService.getNewAccessToken();
          logger.log("HELLLL");
          if (!newAccessTokenResult) {
            logger.log("HELLLL22");
            logger.log('Going to LOgin screen');
            routeService.offAllNamed(AppLinks.login);
            return;
          }
          response = await _dio.post(
            endpoint,
            data: data,
            options: Options(
              headers: {
                'Authorization':
                    'Bearer ${token ?? tokenService.accessToken.value}',
              },
            ),
          );
        } else if (apiResponse.status_code == 403) {
          logger.log('Going to login screen');
          logger.log("HELLLL33");
          _logOut();
          return;
        }
      }
      logger.log('response${response.data}');
      return response.data;
    } on DioException catch (e) {
      logger.log("POST REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      // checkException(e);

      if (e.response?.data != null) {
        return e.response?.data;
      }
      throw "An error occurred";
    } on SocketException {
      throw "seems you are offline";
    } catch (error) {
      throw error.toString();
    }
  }

  Future<dynamic> putRequest({
    required String endpoint,
    required Map? data,
  }) async {
    try {
      late Response response;
      logger.log("PATCH REQUEST DATA:: $data $endpoint");

      // Function to make the actual request
      Future<void> makeRequest() async {
        response = await _dio.put(
          endpoint,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${tokenService.accessToken.value}',
            },
          ),
        );
      }

      await makeRequest();

      logger.log("PATCH REQUEST RESPONSE:: $response");

      final ApiResponseModel apiResponse =
          ApiResponseModel.fromJson(response.data);

      if (apiResponse.status_code == 400) {
        // Attempt to get a new access token
        bool newAccessTokenResult = await tokenService.getNewAccessToken();

        // Log the new token value
        logger.log("New access token: ${tokenService.accessToken.value}");

        if (!newAccessTokenResult) {
          logger.log('Going to Login screen');
          routeService.offAllNamed(AppLinks.login);
          return;
        }

        // Retry the request with the new access token
        await makeRequest();
      }

      return response.data;
    } on DioException catch (e) {
      logger.log("PUT REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      if (e.response?.data != null) {
        return e.response?.data;
      }
      // Throw a custom exception or return an error object
      throw "An error occurred";
    } on SocketException {
      throw "Seems you are offline";
    } catch (error) {
      logger.log("Error: $error");
      throw error.toString();
    }
  }

  Future<dynamic> postRequestFile({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      logger.log("POST REQUEST DATA:: ${data.fields.toString()}");
      logger.log("POST REQUEST DATA:: ${data.files.toString()}");
      late Response response;
      response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${tokenService.accessToken.value}',
            'Content-Type': 'multipart/form-data'
          },
        ),
      );
      logger.log("POST REQUEST RESPONSE:: $response");
      final ApiResponseModel apiResponse =
          ApiResponseModel.fromJson(response.data);
      if (apiResponse.status != "success" || apiResponse.status_code == 401) {
        bool newAccessTokenResult = await tokenService.getNewAccessToken();
        if (!newAccessTokenResult) {
          logger.log('Going to welcome screen');
          routeService.offAllNamed(AppLinks.login);
          return;
        }
        response = await _dio.post(
          endpoint,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${tokenService.accessToken.value}',
              'Content-Type': 'multipart/form-data'
            },
          ),
        );
      }
      return response.data;
    } on DioException catch (e) {
      logger.log("POST REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      if (e.response?.data != null) {
        return e.response?.data;
      }
      throw "An error occurred";
    } on SocketException {
      throw "seems you are offline";
    } catch (error) {
      throw error.toString();
    }
  }

  Future<dynamic> putRequestFile({
    required String endpoint,
    required FormData data,
  }) async {
    try {
      logger.log("PATCH REQUEST DATA:: ${data.fields.toString()}");
      logger.log("PATCH REQUEST DATA:: ${data.files.toString()}");
      late Response response;
      response = await _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${tokenService.accessToken.value}',
            'Content-Type': 'multipart/form-data'
          },
        ),
      );
      logger.log("PATCH REQUEST RESPONSE:: $response");
      final ApiResponseModel apiResponse =
          ApiResponseModel.fromJson(response.data);
      if (apiResponse.status != "success" || apiResponse.status_code == 401) {
        bool newAccessTokenResult = await tokenService.getNewAccessToken();
        if (!newAccessTokenResult) {
          logger.log('Going to welcome screen');
          routeService.offAllNamed(AppLinks.login);
          return;
        }
        response = await _dio.put(
          endpoint,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ${tokenService.accessToken.value}',
              'Content-Type': 'multipart/form-data'
            },
          ),
        );
      }
      return response.data;
    } on DioException catch (e) {
      logger.log("PATCH REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      if (e.response?.data != null) {
        return e.response?.data;
      }
      throw "An error occurred";
    } on SocketException {
      throw "seems you are offline";
    } catch (error) {
      throw error.toString();
    }
  }

  Future<dynamic> getRequest(
    String endpoint,
  ) async {
    try {
      late Response response;
      // late ApiResponseModel apiResponse;
      response = await _dio.get(
        endpoint,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer ${tokenService.accessToken.value}',
          },
        ),
      );
      logger.log("GET REQUEST RESPONSE ($endpoint) :: ${response.data}");
      // apiResponse = ApiResponseModel.fromRawJson(response.data.toString());
      // apiResponse = ApiResponseModel.fromJson(response.data);
      logger.log("msg: GET REQUEST");
      if (response.statusCode == 403) {
        // bool newAccessTokenResult = await tokenService.getNewAccessToken();
        // if (!newAccessTokenResult) {
        logger.log('Going to Login screen');
        routeService.offAllNamed(AppLinks.login);
        // return;
        // }
        // response = await _dio.get(
        //   endpoint,
        //   options: Options(
        //     responseType: ResponseType.plain,
        //     // headers: {
        //     //   'Authorization': 'Bearer ${tokenService.accessToken.value}',
        //     // },
        //   ),
        // );
        // apiResponse = ApiResponseModel.fromJson(response.data);
        // apiResponse = ApiResponseModel.fromRawJson(response.data);
      }
      return response.data;
    } on DioException catch (e) {
      logger.log("GET REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      if (e.response?.data != null) {
        return e.response?.data;
      }
      throw "An error occurred";
    } on SocketException {
      throw "seems you are offline";
    } catch (error) {
      throw error.toString();
    }
  }

  Future<dynamic> deleteRequest({
    required String endpoint,
    Map? data,
    String? token,
  }) async {
    try {
      logger.log("DELETE REQUEST DATA:: $baseURL  $endpoint");
      late Response response;
      response = await _dio.delete(
        endpoint,
        data: data,
        // options: Options(
        //   headers: {
        //     'Authorization':
        //         'Bearer ${token ?? tokenService.accessToken.value}',
        //   },
        // ),
      );
      logger.log("DELETE REQUEST RESPONSE:: $response");
      final ApiResponseModel apiResponse =
          ApiResponseModel.fromJson(response.data);
      if (!endpoint.contains('auth')) {
        if (apiResponse.status_code == 400) {
          // if refresh token returns invalid token, log the user out
          bool newAccessTokenResult = await tokenService.getNewAccessToken();
          logger.log("HELLLL");
          if (!newAccessTokenResult) {
            logger.log("HELLLL22");
            logger.log('Going to LOgin screen');
            routeService.offAllNamed(AppLinks.login);
            return;
          }
          response = await _dio.delete(
            endpoint,
            data: data,
            options: Options(
              headers: {
                'Authorization':
                    'Bearer ${token ?? tokenService.accessToken.value}',
              },
            ),
          );
        } else if (apiResponse.status_code == 403) {
          logger.log('Going to login screen');
          logger.log("HELLLL33");
          _logOut();
          return;
        }
      }
      logger.log('response${response.data}');
      return response.data;
    } on DioException catch (e) {
      logger.log("DELETE REQUEST ERROR ($endpoint) :: ${e.response?.data}");
      if (e.response?.data != null) {
        return e.response?.data;
      }
      throw "An error occurred";
    } on SocketException {
      throw "seems you are offline";
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> _logOut() async {
    try {
      ///
      // await biometricService.clearAll();
      // await authService.logOut(token: tokenService.accessToken.value);
      // await biometricService.clearAll();
      // routeService.offAllNamed(AppLinks.login);
    } catch (err) {
      logger.log("error: $err");
      rethrow;
    } finally {}
  }
}
