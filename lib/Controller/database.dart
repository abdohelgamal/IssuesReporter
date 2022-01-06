import 'package:sqflite/sqflite.dart';

class Dbcontroller {
  late Database database;

  createDataBase() async {
    String databasesPath = await getDatabasesPath();
    databasesPath = databasesPath + '/mydatabase.db';
    database = await openDatabase(databasesPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE TestData (id INTEGER PRIMARY KEY autoincrement, picture TEXT, title TEXT, description TEXT, date TEXT , status TEXT)');
    });
  }

  insertIntoDataBase(
      String path, String title, String description, String status) async {
    await database.insert('TestData', {
      'picture': path,
      'title': title,
      'description': description,
      'status': status
    });
  }
}
