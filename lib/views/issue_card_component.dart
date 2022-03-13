import 'dart:io';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:issues_reporter/views/show_issue_and_edit_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This is a component for showing only the [Issue] information and enables redirecting to another page
///showing more details of the [Issue] and editing it
class IssueCard extends StatelessWidget {
  final Issue issue;
  const IssueCard(this.issue, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return BlocConsumer<BlocForIssues, List<Issue>>(
        listener: (context, state) {},
        builder: (context, state) => InkWell(
            highlightColor: Colors.lightBlue[300],
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IssuePage(issue)));
            },
            child: Card(
                color: const Color.fromARGB(221, 214, 214, 214),
                margin: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 15,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                              child: Image.file(
                                  File(
                                    issue.picture.path,
                                  ),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover)),
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(issue.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600)),
                                    Text('Created At : ${issue.date}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        softWrap: true),
                                    Text('Status : ${issue.status}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        )),
                                    Text('Description : ${issue.description}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        softWrap: true),
                                    Row(children: [
                                      IconButton(
                                          color: Colors.blue,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IssuePage(issue)));
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            bloc.removeIssue(issue);
                                          },
                                          icon: const Icon(Icons.remove))
                                    ])
                                  ]))
                        ])))));
  }
}
