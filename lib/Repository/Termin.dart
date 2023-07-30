import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Termin {
  final int? id;
  // ignore: non_constant_identifier_names
  final String course_name;
  // ignore: non_constant_identifier_names
  final String termin_date;
  // ignore: non_constant_identifier_names
  final int created_by;
  final double? latitude;
  final double? longitude;
  Termin(
      {this.id,
      // ignore: non_constant_identifier_names
      required this.course_name,
      // ignore: non_constant_identifier_names
      required this.termin_date,
      // ignore: non_constant_identifier_names
        this.latitude,
        this.longitude,
      required this.created_by});
  factory Termin.fromMap(Map<String, dynamic> json) => new Termin(
      id: json['id'],
      course_name: json['course_name'],
      termin_date: json['termin_date'],
      created_by: json['created_by']);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course_name': course_name,
      'termin_date': termin_date,
      'created_by': created_by,
    };
  }

  @override
  String toString() {
    return 'Termin id:$id Course Name: $course_name Date: $termin_date Location: ($latitude, $longitude)';  }
}


class TerminHelper {
  static List<Termin> temp = <Termin>[];
}

class TerminDatabaseHelper {
  TerminDatabaseHelper._privateConstructor();
  static final TerminDatabaseHelper instance =
      TerminDatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'termin.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE termin(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          course_name TEXT,
          termin_date TEXT,
          created_by INTEGER,
          latitude REAL,
          longitude REAL
      )
      ''');
  }

  Future<List<Termin>> getTermins() async {
    Database db = await instance.database;
    var dbusers = await db.query('termin', orderBy: 'course_name');
    List<Termin> termins = dbusers.isNotEmpty
        ? dbusers.map((c) => Termin.fromMap(c)).toList()
        : [];
    TerminHelper.temp = termins;
    return termins;
  }

  Future<int> addTermin(Termin new_termin) async {
    Database db = await instance.database;
    Map<String, dynamic> map = new_termin.toMap();
    map['latitude'] = new_termin.latitude;
    map['longitude'] = new_termin.longitude;
    return await db.insert('termin', map);
  }

  Future<int> updateTermin(Termin termin) async {
    Database db = await instance.database;
    return await db.update('termin', termin.toMap(),
        where: "id = ?", whereArgs: [termin.id]);
  }
}
