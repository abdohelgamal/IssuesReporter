import 'package:issues_reporter/models/issue_class.dart';
import 'package:sqflite/sqflite.dart';

///A database controller to manage local database queries
class DbController {
  late Database database;
  String tableName = 'TestData';

  ///It creates a new table for the database if no table exists
  createDataBase() async {
    String databasesPath = await getDatabasesPath();
    databasesPath = databasesPath + '/mydatabase.db';
    await openDatabase(databasesPath, version: 1).then((data) {
      database = data;
      database.transaction((txn) async {
        return await txn.execute(
            '''CREATE TABLE IF NOT EXISTS $tableName (id integer primary key autoincrement, picturePath text
            , title text, description text, date text , status text ,longitude text, latitude text)''');
      });
    });
  }

  ///It adds a record of an [Issue] into the database
  Future<void> insertIntoDataBase(Map<String, dynamic> map) async {
    await database.insert(tableName, map);
  }

  ///It updates a record of an [Issue] in the database
  Future<void> editIssueRecord(Issue issue) async {
    await database.update(tableName, issue.toMap(), where: 'id = ${issue.id}');
  }

  ///It removes a record of an [Issue] from the database
  Future<void> removeFromDataBase(int id) async {
    await database.delete(tableName, where: 'id = $id');
  }

  ///It gets records from the local database as a list
  Future<List<Map<String, Object?>>> getData() async {
    return await database.query(tableName);
  }
}
