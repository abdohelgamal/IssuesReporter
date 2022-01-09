import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:sqflite/sqflite.dart';

class Dbcontroller {
  late Database database;
  String tableName = 'TestData';
  createDataBase() async {
    String databasesPath = await getDatabasesPath();
    databasesPath = databasesPath + '/mydatabase.db';
    await openDatabase(databasesPath, version: 1).then((data) {
      database = data;
      database.transaction((txn) async {
        return await txn.execute(
            '''CREATE TABLE IF NOT EXISTS $tableName (id integer primary key autoincrement, picture text, title text, description text, date text , status text)''');
      });
    });
  }

  Future<void> insertIntoDataBase(String path, String title, String description,
      String date, String status) async {
    await database.insert(tableName, {
      'date': date,
      'picture': path,
      'title': title,
      'description': description,
      'status': status
    });
  }

  Future<void> editIssueRecord(Issue issue) async {
    await database.update(
        tableName,
        {
          'date': issue.date,
          'picture': issue.picture.path,
          'title': issue.title,
          'description': issue.description,
          'status': issue.status
        },
        where: 'id = ${issue.id}');
  }

  Future<void> removeFromDataBase(int id) async {
    await database.delete(tableName, where: 'id = $id');
  }

  Future<List<Map<String, Object?>>> getData() async {
    return await database.query(tableName);
  }
}
