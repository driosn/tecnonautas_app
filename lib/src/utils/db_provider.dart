import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tecnonautas_app/core/models/db_local_trivia.dart';
import 'package:tecnonautas_app/core/models/trivia.dart';
import 'local_trivias.dart' as LT;

class DBProvider {

  Database _database;
  static final DBProvider db = new DBProvider._internal();

  DBProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    List<Trivia> localTrivias = LT.localTrivias;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final locationPathTasksDB = join(documentsDirectory.path, 'Tecnonautas.db');
  
    return await openDatabase(
      locationPathTasksDB,
      version: 21,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE LocalTrivias ('
          'id INTEGER PRIMARY KEY,'
          'name VARCHAR(150),'
          'description VARCHAR(500),'
          'category VARCHAR(150),'
          'points INTEGER,'
          'questions_quantity INTEGER,'          
          'played BOOLEAN,'
          'favorite BOOLEAN'
          ');'
        );

        for(int i = 0; i < localTrivias.length; i++) {
          await db.insert('LocalTrivias', {
            "name" : localTrivias[i].name,
            "description" : localTrivias[i].description,
            "category" : localTrivias[i].category,
            "points" : localTrivias[i].points,
            "questions_quantity" : localTrivias[i].qtyPreg,
            "played" : 0,
            "favorite" : 0            
          });
        }
      }
    ); 
  }

  // Crud LocalTriviasData
  
  // Read
  Future<List<DBLocalTrivia>> readLocalTrivias() async {
    final db = await database;
    final response = await db.query('LocalTrivias');

    if (response.isNotEmpty) {
      List<DBLocalTrivia> auxiliarList = List<DBLocalTrivia>();
      response.forEach((element) {
        auxiliarList.add(DBLocalTrivia.fromJson(element));
      });
      return auxiliarList;
    }
    return [];
   }

   Future<int> setTriviaToFavorite(int mTriviaId) async {
     final db = await database;
     final response = await db.rawUpdate('UPDATE LocalTrivias SET favorite=1 WHERE id=$mTriviaId');
     return response;
   }

   Future<int> setTriviaToNotFavorite(int mTriviaId) async {
     final db = await database;
     final response = await db.rawUpdate('UPDATE LocalTrivias SET favorite=0 WHERE id=$mTriviaId');
     return response;
   }

   Future<int> setTriviaToPlayed(int mTriviaId) async {
     final db = await database;
     final response = await db.rawUpdate('UPDATE LocalTrivias SET played=1 WHERE id=$mTriviaId');
     return response;
   }

   Future<int> setTriviaToNotPlayed(int mTriviaId) async {
     final db = await database;
     final response = await db.rawUpdate('UPDATE LocalTrivias SET played=0 WHERE id=$mTriviaId');
     return response;
   }
}