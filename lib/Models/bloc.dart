import 'package:bloc/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';

class BlocForIssues extends Cubit<List<Issue>> {
  BlocForIssues() : super(List.empty());

  List<Issue> issues = [];

  void addNewIssue(Issue issue) {
    issues.add(issue);
    print(issues.length);
    emit(issues);
  }

  void removeIssue(Issue issue) {
    issues.remove(issue);
    print(issues.length);
    emit(issues);
  }
}
