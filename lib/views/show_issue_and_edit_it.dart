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
import 'package:map_picker/map_picker.dart';

///This Page shows the information of the [Issue] and edits its info
class IssuePage extends StatefulWidget {
  IssuePage(this.issue, {Key? key}) : super(key: key) {
    date = issue.date;
    description = issue.description;
    title = issue.title;
    picture = XFile(issue.picturePath);
    status = issue.status;
    id = issue.id;
    longitude = issue.longitude;
    latitude = issue.latitude;
  }
  late Issue issue;
  late int id;
  late String title;
  late XFile picture;
  late String description;
  late String status;
  late String date;
  String? longitude;
  String? latitude;

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  bool editingMode = false;
  late XFile? newPicture;
  late TextEditingController newTitle = TextEditingController();
  late TextEditingController newDescription = TextEditingController();
  late String newStatus;
  String? longitude;
  String? latitude;
  CameraPosition camPos = const CameraPosition(target: LatLng(31, 31), zoom: 5);
  MapPickerController mapController = MapPickerController();

  TextStyle txtStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  void initState() {
    newStatus = widget.status;
    newDescription.text = widget.description;
    newTitle.text = widget.title;
    newPicture = widget.picture;
    if (widget.latitude != null) {
      latitude = widget.latitude;
    }
    if (widget.longitude != null) {
      longitude = widget.longitude;
    }
    super.initState();
  }

  @override
  void dispose() {
    newTitle.dispose();
    newDescription.dispose();
    super.dispose();
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
                                    newPicture!.path,
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
                                    newStatus,
                                    longitude,
                                    latitude));
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
                physics: const BouncingScrollPhysics(),
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: editingMode == false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Column(
                                    mainAxisSize: MainAxisSize.min,
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
                                if (widget.latitude != null &&
                                    widget.longitude != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 300,
                                        child: GoogleMap(
                                            scrollGesturesEnabled: false,
                                            tiltGesturesEnabled: false,
                                            rotateGesturesEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                                    zoom: 8,
                                                    target: LatLng(
                                                        double.parse(
                                                            widget.latitude!),
                                                        double.parse(widget
                                                            .longitude!)))),
                                      ),
                                    ),
                                  )
                                else
                                  Text('No location', style: txtStyle),
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
                            if (longitude == null && latitude == null)
                              TextButton.icon(
                                  label: const Text(
                                      'Add an a location (optional)'),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            insetPadding:
                                                const EdgeInsets.all(40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 30,
                                                          color: Colors.red,
                                                        )),
                                                  ),
                                                  const Text(
                                                    'Please choose the location of the issue',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    height: 400,
                                                    child: MapPicker(
                                                        iconWidget: const Icon(
                                                          Icons.location_pin,
                                                          color: Colors.red,
                                                          size: 50,
                                                        ),
                                                        mapPickerController:
                                                            mapController,
                                                        child: GoogleMap(
                                                            onCameraMove:
                                                                ((position) {
                                                              camPos = position;
                                                            }),
                                                            onCameraIdle: () {
                                                              mapController
                                                                  .mapFinishedMoving!();
                                                            },
                                                            onCameraMoveStarted:
                                                                () {
                                                              mapController
                                                                  .mapMoving!();
                                                            },
                                                            initialCameraPosition:
                                                                camPos)),
                                                  ),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<
                                                                  OutlinedBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)))),
                                                      onPressed: () {
                                                        longitude = camPos
                                                            .target.longitude
                                                            .toString();
                                                           
                                                        latitude = camPos
                                                            .target.latitude
                                                            .toString();
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          'Choose this location'))
                                                ],
                                              ),
                                            ),
                                          );
                                        }).whenComplete(() {
                                      setState(() {});
                                    });
                                  },
                                  icon: const Icon(Icons.add))
                            else
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      'Current selected location is $longitude , $latitude',
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(fontSize: 15),
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
