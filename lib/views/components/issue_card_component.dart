import 'dart:io';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issues_reporter/views/screens/show_issue_and_edit_it.dart';

///This is a component for showing only the [Issue] information and enables redirecting to another page
///showing more details of the [Issue] and editing it
class IssueCard extends StatelessWidget {
  final Issue issue;
  const IssueCard(this.issue, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Card(
        color: const Color.fromARGB(221, 243, 226, 203),
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 15,
        child: InkWell(
            borderRadius: BorderRadius.circular(35),
            highlightColor: const Color.fromARGB(172, 103, 221, 236),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IssuePage(issue)));
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                          child: Image.file(
                              File(
                                issue.picturePath,
                              ),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover)),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(issue.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text('Created At : ${issue.date}',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      softWrap: true),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text('Status : ${issue.status}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      )),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child:
                                      Text('Description : ${issue.description}',
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                          softWrap: true),
                                ),
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
                    ]))));
  }
}
