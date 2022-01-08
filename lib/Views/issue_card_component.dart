import 'dart:io';
import 'package:facegraph_assessment/Models/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:facegraph_assessment/Views/show_issue_and_edit_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;

  IssueCard(this.issue, {Key? key}) : super(key: key);
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
          margin: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Image.file(
                        File(
                          issue.picture.path,
                        ),
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('ID : ${issue.id}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                        Text(
                          issue.title,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Created At : ${issue.date}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          softWrap: true,
                        ),
                        Text(
                          'Status : ${issue.status}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Description : ${issue.description}',
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          softWrap: true,
                        ),
                        Row(
                          children: [
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
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
