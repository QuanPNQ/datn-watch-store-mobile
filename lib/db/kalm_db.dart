// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class KalmDB {
//   static final KalmDB kalmDBProvider = KalmDB();
//
//   static Database? _database;
//
//   Future<Database> get database async => _database ??= await _initDatabase();
//
//   final _dbName = 'kalm.db';
//   final _version = 6;
//
//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _dbName);
//     return await openDatabase(path,
//         version: _version,
//         onCreate: _onCreate,
//         onConfigure: _onConfigure,
//         onUpgrade: _onUpgrade);
//   }
//
//   Future _onConfigure(Database db) async {
//     await db.execute('PRAGMA foreign_keys = ON');
//   }
//
//   Future _onCreate(Database db, int version) async {
//     debugPrint('_onCreate');
//     await db.execute(UserDeviceDao.SQL_USER_DEVICE);
//   }
//
//   Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < newVersion) {
//       debugPrint('_onUpgrade');
//       await db.execute(SettingsDAO.SQL_SETTINGS);
//     }
//   }
// }
