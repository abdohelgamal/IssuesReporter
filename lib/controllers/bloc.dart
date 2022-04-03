import 'package:bloc/bloc.dart';
import 'package:issues_reporter/controllers/database.dart';
import 'package:issues_reporter/models/issue_class.dart';

///A [Cubit] class to handle state management of the application and rebuild events
///
///It launches the database controller upon creation and then updates the UI with issues if there any
class BlocForIssues extends Cubit<List<Issue>> {
  BlocForIssues() : super(List.empty()) {
    db = DbController();
    db.createDataBase().whenComplete(() {
      updateIssuesList();
    });
  }

  late DbController db;
  List<Issue> allIssues = [];
   List<Issue> openIssues = [];
    List<Issue> closedIssues = [];


  ///It get the data stored in the local database and then maps them into a list of [Issue] model
  ///and then rebuilds the UI as the state changes
  void updateIssuesList() async {
    List<Map> temp = await db.getData();
    allIssues = temp.map((val) => Issue.fromMap(val)).toList();
    openIssues = allIssues.where((element) => element.status == 'Open',).toList();
    closedIssues = allIssues.where((element) => element.status == 'Closed',).toList();
    emit(allIssues);
  }

  ///It adds a new [Issue] to the local database and then updates the state with the new data
  void addNewIssue(Issue issue) async {
    await db.insertIntoDataBase(issue.toMap());
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
