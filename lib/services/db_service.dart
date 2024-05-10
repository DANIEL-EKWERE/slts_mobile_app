import 'dart:async';

// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slts_mobile_app/models/violations/add_violations.dart';
import 'package:slts_mobile_app/services/logger.dart';
// import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

DatabaseService get databaseService => Get.find();

class DatabaseService {
  Logger logger = Logger('DatabaseService');

  late Database _database;
  final box = GetStorage();

  final databaseName = "pending_uploads.db";

  static final DatabaseService _cache = DatabaseService._internal();

  factory DatabaseService() {
    return _cache;
  }

  DatabaseService._internal() {
    init();
  }

  Future<void> init() async {
    logger.log('Initializing DatabaseService');
    // final databasePath = await getDatabasesPath();
    // final path = join(databasePath, databaseName);

    // // init database
    // _database = await openDatabase(path, version: 1,
    //     onCreate: (Database db, int version) async {
    //   await db.execute("""
    //     CREATE TABLE pending_uploads (
    //       id INTEGER PRIMARY KEY,
    //       carPhotos TEXT,
    //       plateNumber TEXT,
    //       location TEXT,
    //       violationType TEXT,
    //       comment TEXT
    //     )
    //   """);
    // });
  }

  Future<dynamic> write(String key, dynamic value) async {
    box.write(key, value);
    
  }

  Future<String> insertPendingUpload(AddViolations violations) async {
    logger.log('inserting PendingUpload');
    final key = 'violation_${DateTime.now().millisecondsSinceEpoch}';
    await box.write(key, violations.toMap());
    logger.log('inserting PendingUpload success');
    return key;
  }

  FutureOr<List<AddViolations>> getPendingUploads(String? para) async {
    final List<String> keys = box
        .getKeys()
        .where((key) => key.toString().startsWith('violation_'))
        .toList();
    final List<AddViolations> violationsList = [];

    for (final key in keys) {
      final Map<String, dynamic>? data = box.read(key);
      if (data != null) {
      //  violationsList.add(AddViolations.fromMap(data));
      }
    }

    return violationsList;
  }

  Future<void> insertPendingUpload1(AddViolations upload) async {
    logger.log('inserting PendingUpload');
    await _database.insert(
      'pending_uploads',
      upload.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    logger.log('inserting PendingUpload success');
  }

  Future<List<AddViolations>> getPendingUploads1() async {
    final List<Map<String, Object?>> queryResult = await _database.query(
      'pending_uploads',
    );

    return queryResult.map((e) => AddViolations.fromMap(e)).toList();
  }

  Future<void> deletePendingUpload(int id) async {
    await _database.delete(
      'pending_uploads',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
