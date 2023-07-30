import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class User{
  final int? id;
  // ignore: non_constant_identifier_names
  final String user_name;
  // ignore: non_constant_identifier_names
  final String user_email;
  // ignore: non_constant_identifier_names
  final String user_pass;

  // ignore: non_constant_identifier_names
  User({this.id,required  this.user_name,required  this.user_email,required this.user_pass});


factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json['id'],
        user_name: json['user_name'],
        user_email: json['user_email'],
        user_pass: json['user_pass']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': user_name,
      'user_email': user_email,
      'user_pass': user_pass,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          user_name TEXT,
          user_email TEXT,
          user_pass TEXT,
      )
      ''');
  }
  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var dbusers = await db.query('users', orderBy: 'user_name');
    List<User> users = dbusers.isNotEmpty
        ? dbusers.map((c) => User.fromMap(c)).toList()
        : [];
    return users;
  }

  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }
  
  Future<int> update(User user) async {
    Database db = await instance.database;
    return await db.update('users', user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }
}
