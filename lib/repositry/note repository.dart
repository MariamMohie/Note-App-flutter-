
// the connection with database
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NoteRepository {
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

  // open  and create Db

    static Future<Database> _database() async{
    final database =openDatabase(
      join(await getDatabasesPath(),_dbName),
      onCreate: (db,version){
        return db.execute('CREATE TABLE  $_tableName(id INTEGER PRIMARY KEY ,title TEXT, description TEXT, createdAt TEXT)');
      },
      version: 1,

    );
    return database;
  }
  //insert function
  //we used static to call it by the class name without creating object
   static insert( {required Note note})async{
     // values will be stored in this variable
     final db = await _database();
     await db.insert(
         _tableName, //name
       //will go to ToMap function in Note class and convert it to Map
         note.toMap(),//values
       conflictAlgorithm: ConflictAlgorithm.replace,

     );
  }

  // return List of notes
  static Future<List<Note>> getNote() async{
      final db =await _database();

      // fetch data in table
      final List<Map<String,dynamic>> maps = await db.query(_tableName);


      //convert data from Map to list
    return List.generate(maps.length,(i){
      return Note(
        id: maps[i]['id']as int,
        title: maps[i]['title']as String,
        description: maps[i]['description']as String,
        createdAt: DateTime.parse(maps[i]['createdAt'])as DateTime

      );
      });


  }
  // update function
  static update ({required Note note})async{
      final db = await _database();
      await db.update(
          _tableName,
          note.toMap(),
          where: 'id = ?',
          whereArgs: [note.id]
      );

  }

  static delete ({required Note note})async{
    final db = await _database();
    await db.delete(
        _tableName,

        where: 'id = ?',
        whereArgs: [note.id]
    );

  }


}