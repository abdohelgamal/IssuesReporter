import 'package:bloc/bloc.dart';
import 'package:facegraph_assessment/Controller/database.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:image_picker/image_picker.dart';

class BlocForIssues extends Cubit<List<Issue>> {
  BlocForIssues() : super(List.empty()) {
    db = Dbcontroller();
    db.createDataBase().whenComplete(() {
      updateIssuesList();
    });
  }

  late Dbcontroller db;
  List<Issue> issues = [];

  void updateIssuesList() async {
    List<Map> temp = await db.getData();
    issues = temp
        .map((val) => Issue(val['id'], val['title'], XFile(val['picture']),
            val['description'], val['date'], val['status']))
        .toList();
    emit(issues);
  }

  void addNewIssue(Issue issue) async {
    await db.insertIntoDataBase(issue.picture.path, issue.title,
        issue.description, issue.date, issue.status);
    updateIssuesList();
  }
void editIssue(Issue issue)async{
  await db.editIssueRecord(issue);
  updateIssuesList();
}
  void removeIssue(Issue issue) async {
    await db.removeFromDataBase(issue.id);
    updateIssuesList();
  }
}
