import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/controllers/functions.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

///This Page shows the information of the [Issue] and edits its info
class IssuePage extends StatefulWidget {
  IssuePage(this.issue, {Key? key}) : super(key: key) {
    date = issue.date;
    description = issue.description;
    title = issue.title;
    picture = issue.picture;
    status = issue.status;
    id = issue.id;
  }
  late Issue issue;
  late int id;
  late String title;
  late XFile picture;
  late String description;
  late String status;
  late String date;

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  bool editingMode = false;
  late XFile? newPicture;
  late TextEditingController newTitle = TextEditingController();
  late TextEditingController newDescription = TextEditingController();
  late String newStatus;

  TextStyle txtStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  void initState() {
    newStatus = widget.status;
    newDescription.text = widget.description;
    newTitle.text = widget.title;
    newPicture = widget.picture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return BlocConsumer<BlocForIssues, List<Issue>>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 245, 120, 82),
                title: Text(widget.title),
                actions: editingMode == false
                    ? [
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                editingMode = true;
                              });
                            },
                            icon: const Icon(Icons.edit))
                      ]
                    : [
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                editingMode = false;
                              });
                            },
                            icon: const Icon(Icons.close)),
                        IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              if (validate(newTitle.text, newPicture,
                                  newDescription.text)) {
                                bloc.editIssue(Issue(
                                    widget.id,
                                    newTitle.text,
                                    newPicture!,
                                    newDescription.text,
                                    formatDate(DateTime.now(), [
                                      yyyy,
                                      '-',
                                      mm,
                                      '-',
                                      dd,
                                      '  ',
                                      hh,
                                      ':',
                                      nn
                                    ]),
                                    newStatus));
                                Navigator.pop(context);
                              } else {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                            content: const Text(
                                                'Please enter all missing data and a picture',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Ok'))
                                            ]));
                              }
                            })
                      ]),
            body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: editingMode == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Issue Id : ${widget.id}',
                                          style: txtStyle),
                                      Text('Issue Title : ${widget.title}',
                                          style: txtStyle),
                                      Text(
                                          'Issue Description : ${widget.description}',
                                          style: txtStyle),
                                      Text('Issue Status : ${widget.status}',
                                          style: txtStyle),
                                      Text('Issue Date : ${widget.date}',
                                          style: txtStyle)
                                    ]),
                                Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: Image.file(
                                            File(widget.picture.path),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6)))
                              ])
                        : Column(children: [
                            TextField(
                                controller: newTitle,
                                decoration: const InputDecoration(
                                    helperText: 'Enter new title')),
                            TextField(
                                controller: newDescription,
                                decoration: const InputDecoration(
                                    helperText: 'Enter new description')),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text('Status :'),
                                      Row(children: [
                                        Radio(
                                            value: 'Open',
                                            groupValue: newStatus,
                                            onChanged: (String? val) {
                                              setState(() {
                                                newStatus = val!;
                                              });
                                            }),
                                        const Text('Open')
                                      ]),
                                      Row(children: [
                                        Radio(
                                            value: 'Closed',
                                            groupValue: newStatus,
                                            onChanged: (String? val) {
                                              setState(() {
                                                newStatus = val!;
                                              });
                                            }),
                                        const Text('Closed')
                                      ])
                                    ])),
                            if (newPicture == null)
                              TextButton.icon(
                                  label: const Text('Add an image'),
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    final XFile? photo = await imagePicker
                                        .pickImage(source: ImageSource.camera);
                                    if (photo is XFile) {
                                      setState(() {
                                        newPicture = photo;
                                      });
                                    } else {
                                      return;
                                    }
                                  },
                                  icon: const Icon(Icons.add)),
                            if (newPicture != null)
                              Stack(children: [
                                Image.file(File(newPicture!.path),
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width: MediaQuery.of(context).size.height *
                                        0.4,
                                    fit: BoxFit.cover),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        newPicture = null;
                                      });
                                    },
                                    color: Colors.white,
                                    iconSize: 35,
                                    icon: const Icon(Icons.cancel_rounded))
                              ], alignment: Alignment.topRight)
                          ])))));
  }
}
