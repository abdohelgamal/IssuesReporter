import 'package:bloc/bloc.dart';
import 'package:issues_reporter/controllers/database.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:image_picker/image_picker.dart';

///A [Cubit] class to handle state management of the application and rebuild events
///
///It launches the database controller upon creation and then updates the UI with issues if there any
class BlocForIssues extends Cubit<List<Issue>> {
  BlocForIssues() : super(List.empty()) {
    db = Dbcontroller();
    db.createDataBase().whenComplete(() {
      updateIssuesList();
    });
  }

  late Dbcontroller db;
  List<Issue> issues = [];

  ///It get the data stored in the local database and then maps them into a list of [Issue] model
  ///and then rebuilds the UI as the state changes
  void updateIssuesList() async {
    List<Map> temp = await db.getData();
    issues = temp
        .map((val) => Issue(val['id'], val['title'], XFile(val['picture']),
            val['description'], val['date'], val['status']))
        .toList();
    emit(issues);
  }

  ///It adds a new [Issue] to the local database and then updates the state with the new data
  void addNewIssue(Issue issue) async {
    await db.insertIntoDataBase(issue.picture.path, issue.title,
        issue.description, issue.date, issue.status);
    updateIssuesList();
  }

  ///It edits an [Issue] in the local database and then updates the state with the new data
  void editIssue(Issue issue) async {
    await db.editIssueRecord(issue);
    updateIssuesList();
  }

  ///It removes an [Issue] from the local database and then updates the state with the new data
  void removeIssue(Issue issue) async {
    await db.removeFromDataBase(issue.id);
    updateIssuesList();
  }
}
