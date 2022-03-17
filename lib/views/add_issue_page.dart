import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/controllers/functions.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

///This Page is for entering a new [Issue] and its details
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
  String? longitude;
  String? latitude;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return BlocConsumer<BlocForIssues, List<Issue>>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 245, 120, 82),
              child: const Icon(Icons.add, size: 30),
              onPressed: () {
                if (validate(title, picture, description)) {
                  bloc.addNewIssue(Issue(
                      1,
                      title,
                      picture!.path,
                      description,
                      formatDate(DateTime.now(),
                          [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn]),
                      status,
                      latitude,
                      longitude));
                  Navigator.pop(context);
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                              content: const Text(
                                  'Please enter all missing data and a picture',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
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
                backgroundColor: const Color.fromARGB(255, 245, 120, 82),
                title: const Text('Please enter issue details',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            maxLines: 1,
                            decoration:
                                const InputDecoration(hintText: 'Title :'))),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            maxLines: 3,
                            decoration: const InputDecoration(
                                isCollapsed: true, hintText: 'Description :'))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Status :'),
                          Row(children: [
                            Radio(
                                value: 'Open',
                                groupValue: status,
                                onChanged: (String? val) {
                                  setState(() {
                                    status = val!;
                                  });
                                }),
                            const Text('Open')
                          ]),
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
                        ]),
                    if (longitude == null && latitude == null)
                      TextButton.icon(
                          label: const Text('Add an a location (optional)'),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )),
                                        ),
                                        const Text(
                                            'Please choose the location of the issue',style: TextStyle(fontSize: 20),),
                                        Container(padding: const EdgeInsets.all(18),
                                          width: 300,
                                          height: 400,
                                          child: GoogleMap(
                                              onTap: (latlong) {
                                             
                                                  latitude = latlong.latitude
                                                      .toString();
                                                  longitude = latlong.longitude
                                                      .toString();
                                               
                                              },
                                              initialCameraPosition:
                                                  const CameraPosition(
                                                      target:  LatLng(31,
                                                          31),zoom: 5)),
                                        ),
                                      ],
                                    ),
                                  );
                                }).whenComplete(() {
                                   setState(() {
                                     
                                   });
                                });
                          },
                          icon: const Icon(Icons.add)),
                    if (longitude != null && latitude != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              'Current selected location is $longitude , $latitude',
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  longitude = null;
                                  latitude = null;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      ),
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
                          Image.file(File(picture!.path),
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.height * 0.4,
                              fit: BoxFit.cover),
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
                      )
                  ]),
            )))));
  }
}
