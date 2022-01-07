import 'package:bloc/bloc.dart';
import 'package:facegraph_assessment/Controller/database.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class BlocForIssues extends Cubit<List<Issue>> {
  BlocForIssues() : super(List.empty()) {
    db = Dbcontroller();
    createDataBase();
    print('bloc create');
  }

  late Dbcontroller db;
  List<Issue> issues = [];

  createDataBase() async {
    String databasesPath = await getDatabasesPath();
    databasesPath = databasesPath + '/mydatabase.db';
    await openDatabase(databasesPath, version: 1).then((database) {
      db.database = database;
      print('database created');
      db.database.transaction((txn) async {
        return await txn.execute(
            '''CREATE TABLE TestData (id integer primary key autoincrement, picture text, title text, description text, date text , status text)''');
      });
    });
  }

  void updateIssuesList() async {
    List<Map> temp = await db.getdata();
    print(temp);
    issues = temp
        .map((val) => Issue(val['id'], val['title'], XFile(val['picture']) ,
            val['description'], val['date'], val['status']))
        .toList();
    emit(issues);
  }

  void addNewIssue(Issue issue) async {
    await db.insertIntoDataBase(issue.picture.path, issue.title,
        issue.description, issue.date, issue.status);
    updateIssuesList();
  }

  void removeIssue(Issue issue) async {
    await db.removeFromDataBase(issue.id);
    updateIssuesList();
  }
}
