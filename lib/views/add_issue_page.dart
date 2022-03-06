import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/controllers/functions.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddIssuePage extends StatefulWidget {
  const AddIssuePage({Key? key}) : super(key: key);

  @override
  State<AddIssuePage> createState() => _AddIssuePageState();
}

class _AddIssuePageState extends State<AddIssuePage> {
  String title = '';
  XFile? picture;
  String description = '';
  String status = 'Open';

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return BlocConsumer<BlocForIssues, List<Issue>>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, size: 30),
              onPressed: () {
                if (validate(title, picture, description)) {
                  bloc.addNewIssue(Issue(
                      1,
                      title,
                      picture!,
                      description,
                      formatDate(DateTime.now(),
                          [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn]),
                      status));
                  Navigator.pop(context);
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                              content: const Text(
                                'Please enter all missing data and a picture',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'))
                              ]));
                }
              },
            ),
            appBar: AppBar(
              title: const Text(
                'Please enter issue details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'Title :',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        maxLines: 3,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          hintText: 'Description :',
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Status :'),
                              Row(
                                children: [
                                  Radio(
                                      value: 'Open',
                                      groupValue: status,
                                      onChanged: (String? val) {
                                        setState(() {
                                          status = val!;
                                        });
                                      }),
                                  const Text('Open')
                                ],
                              ),
                              Row(children: [
                                Radio(
                                    value: 'Closed',
                                    groupValue: status,
                                    onChanged: (String? val) {
                                      setState(() {
                                        status = val!;
                                      });
                                    }),
                                const Text('Closed')
                              ])
                            ])),
                    if (picture == null)
                      TextButton.icon(
                          label: const Text('Add an image'),
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            final XFile? photo = await imagePicker.pickImage(
                                source: ImageSource.camera);
                            if (photo is XFile) {
                              setState(() {
                                picture = photo;
                              });
                            } else {
                              return;
                            }
                          },
                          icon: const Icon(Icons.add)),
                    if (picture != null)
                      Stack(
                        children: [
                          Image.file(
                            File(picture!.path),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  picture = null;
                                });
                              },
                              color: Colors.white,
                              iconSize: 35,
                              icon: const Icon(Icons.cancel_rounded))
                        ],
                        alignment: Alignment.topRight,
                      ),
                  ]),
            ))));
  }
}
