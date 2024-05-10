import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;

// Define a key and IV for encryption
final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
final iv = encrypt.IV.fromLength(16);
// TextEditingController vinController = TextEditingController();
// TextEditingController violationCodeController = TextEditingController();
// TextEditingController fineController = TextEditingController();
// TextEditingController vehicleTypeController = TextEditingController();
// TextEditingController vehicleMakeController = TextEditingController();
// TextEditingController vehicleYearController = TextEditingController();
// TextEditingController firstNameController = TextEditingController();
// TextEditingController lastNameController = TextEditingController();
// TextEditingController genderController = TextEditingController();
// TextEditingController creatorController = TextEditingController();
// TextEditingController violationController = TextEditingController();

class AddViolations {
  final dynamic id;
  final List<dynamic> evidences;
  final String plateNumber;
  final dynamic violationLocation;
  final dynamic violationType;
  final dynamic comment;
  // adding new fields
  final dynamic vin;
  final dynamic violationCode;
  final dynamic fine;
  final dynamic vehicleType;
  final dynamic vehicleMake;
  final dynamic vehicleYear;
  final String firstName;
  final String lastName;
  final dynamic gender;
 final String? createdAt;
  final String violation;
//  final List<String> evidence;
  AddViolations({
     this.id,
    required this.evidences,
    required this.plateNumber,
    required this.violationLocation,
    required this.violationType,
    required this.comment,
    // added this
    required this.vin,
    required this.violationCode,
    required this.fine,
    required this.vehicleType,
    required this.vehicleMake,
    required this.vehicleYear,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.createdAt,
    required this.violation,
    //  required this.evidence,
  });

  // Convert list of strings to a single string for database storage
  // String carPhotosToString() {
  //   return carPhotos.join(', ');
  // }

  // Encrypt the list of carPhotos
  String encryptCarPhotos() {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    List<int> allBytes = [];

    // Read and concatenate bytes of all files
    for (var i = 0; i < evidences.length; i++) {
      List<int> fileBytes = File(evidences[i]).readAsBytesSync();
      allBytes.addAll(fileBytes);
    }

    // Encrypt concatenated bytes
    final encryptedData = encrypter.encryptBytes(allBytes, iv: iv);
    return encryptedData.base64;
  }

  // Decrypt the stored string back to a list of carPhotos
  static List<String> decryptCarPhotos(String encryptedString) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedString, iv: iv);
    return decrypted.split(',');
  }

  factory AddViolations.fromMap(Map<String, dynamic> json) {
    // List<String> carPhotosList = json['evidences'] != null
    //     ? List<String>.from(jsonDecode(json['evidences']['filePath']))
    //     : [];
    //  List<String> evidenceList = json['evidence'] != null
    // ? List<String>.from(jsonDecode(json['evidence']))
    // : [];
    return AddViolations(
      id: json['id'],
      //evidences: carPhotosList,
      plateNumber: json['plateNumber'],
      violationLocation: json['violationLocation'],
      violationType: json['violationType'],
      comment: json['comment'],
      // adding this
      vin: json['vin'],
      violationCode: json['violationCode'],
      fine: json['fine'],
      vehicleType: json['vehicleType'],
      vehicleMake: json['vehicleMake'],
      vehicleYear: json['vehicleYear'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      createdAt: json['createdAt'],
      violation: json['violation'],

      evidences: json["evidences"] == null ? [] : List<Evidence>.from(json["evidences"]!.map((x) => Evidence.fromJson(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'evidences': jsonEncode(evidences),
      'plateNumber': plateNumber,
      'violationLocation': violationLocation,
      'violationType': violationType,
      'comment': comment,
      // added some fields here
      'vin': vin,
      'violationCode': violationCode,
      'fine': fine,
      'vehicleType': vehicleType,
      'vehicleMake': vehicleMake,
      'vehicleYear': vehicleYear,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'createdAt': createdAt,
      'violation': violation,
      //  'evidence': jsonEncode(evidence),
    };
  }
}

class Evidence {
  final dynamic id;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  Evidence(
      {required this.id,
      required this.filePath,
      required this.createdAt,
      required this.updatedAt});

  factory Evidence.fromJson(Map<String, dynamic> json) {
    return Evidence(
        id: json['id'],
        filePath: json['filePath'] ??
            'http://139.162.207.19:8080/api/v1/violation_evidences/00a8d7d7c11be1090663c0e30d63e631.jpg',
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

     Map<String, dynamic> toJson() => {
        "id": id,
        "filePath": filePath,
       "createdAt": DateTime.now().toString(),
      "updatedAt": DateTime.now().toString(),
    };
}
