import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/utils.dart';

DeviceService get deviceService => Get.find();

class DeviceService {
  Logger logger = Logger('DeviceService');

  RxString? currentAddress = ''.obs;
  Rx<Position?> currentPosition = Rx<Position?>(null);

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition.value!.latitude, currentPosition.value!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress!.value =
          "${place.street}, ${place.subLocality} ${place.subAdministrativeArea}";
      logger.log("Address:: ${currentAddress!.value}");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    try {
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition.value = position;
        getAddressFromLatLng(currentPosition.value!);
      });
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }
  Future<void> getUserPosition() async {
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition.value = position;
        getAddressFromLatLng(currentPosition.value!);
      });
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSuccessSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message: 'Location services are disabled. Please enable the services',
          color: grey4);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSuccessSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            message: 'Location permissions are denied',
            color: grey4);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSuccessSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          color: grey4);
      return false;
    }
    return true;
  }
}
