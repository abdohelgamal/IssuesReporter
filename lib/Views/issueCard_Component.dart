import 'dart:io';
import 'package:facegraph_assessment/Models/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;
  late BlocForIssues bloc;

  IssueCard(this.issue, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of(context);
    return BlocConsumer<BlocForIssues, List<Issue>>(
      listener: (context, state) {},
      builder: (context, state) => Card(
        margin: const EdgeInsets.all(15),
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(
                      File(
                        issue.picture.path,
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('ID : ${issue.id}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600)),
                    Text(
                      issue.title,
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
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                    Row(
                      children: [
                        IconButton(
                            color: Colors.blue,
                            onPressed: () {},
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
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
