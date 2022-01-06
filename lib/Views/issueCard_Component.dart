import 'dart:io';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;

  const IssueCard(this.issue, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.file(
                  File(
                    issue.picture.path,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('ID : ${issue.id}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                  Text(
                    issue.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Created At : ${issue.date}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    softWrap: true,
                  ),
                  Text(
                    'Status : ${issue.status}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Description : ${issue.description}',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    softWrap: true,
                  ),
                  Row(
                    children: [
                      IconButton(
                          color: Colors.blue,
                          onPressed: () {},
                          icon: Icon(Icons.edit)),
                      IconButton(
                          color: Colors.red,
                          onPressed: () {},
                          icon: Icon(Icons.remove))
                    ],
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
