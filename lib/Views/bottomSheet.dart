import 'dart:io';
import 'package:facegraph_assessment/Models/bloc.dart';
import 'package:facegraph_assessment/Models/issue_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BtmSheet extends StatefulWidget {
  BtmSheet({Key? key}) : super(key: key);

  @override
  State<BtmSheet> createState() => _BtmSheetState();
}

class _BtmSheetState extends State<BtmSheet> {
  
  String title = '';
  XFile? picture = null;
  String description = '';
  String status = '';

  @override
  Widget build(BuildContext context) {
   
    return SizedBox.expand(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocBuilder<BlocForIssues, List<Issue>>(
          builder: (context, list) { var blocProvider = BlocProvider.of<BlocForIssues>(context);
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Please enter issue details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status :'),
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            child: Text('Closed'),
                            value: 'Closed',
                          ),
                          DropdownMenuItem(
                            child: Text('Open'),
                            value: 'Open',
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            status = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      IconButton(
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
                        Image.file(
                          File(picture!.path),
                          height: 250,
                          width: 250,
                        )
                    ],
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      if (title != '' && picture != null && description != '') {
                        blocProvider.addNewIssue(Issue(1, title, picture!,
                            description, DateTime.now().toString(), status));
                        Navigator.pop(
                          context,
                        );
                      } else {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  content: const Text(
                                      'Please enter all missing data and a picture'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'))
                                  ],
                                ));
                      }
                    },
                    icon: const Icon(CupertinoIcons.add),
                    label: const Text('Add Issue'))
              ],
            ),
          );
          },
        ),
      ),
    );
  }
}
