import 'package:sqflite/sqflite.dart';

class Dbcontroller {
  late Database database;

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
