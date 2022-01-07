import 'package:sqflite/sqflite.dart';

class Dbcontroller {
  late Database database;

    createDataBase() async {
    String databasesPath = await getDatabasesPath();
    databasesPath = databasesPath + '/mydatabase.db';
    await openDatabase(databasesPath, version: 1).then((data) {
      database = data;
      print('database created');
      database.transaction((txn) async {
        return await txn.execute(
            '''CREATE TABLE TestData (id integer primary key autoincrement, picture text, title text, description text, date text , status text)''');
      });
    });
  }

  Future<void> insertIntoDataBase(String path, String title, String description,
      String date, String status) async {
    await database.insert('TestData', {
      'date': date,
      'picture': path,
      'title': title,
      'description': description,
      'status': status
    });
  }

  Future<void> removeFromDataBase(int id) async {
    await database.delete('TestData', where: 'id = $id');
  }

  Future<List<Map<String, Object?>>> getdata() async {
    return await database.query('TestData');
  }
}
