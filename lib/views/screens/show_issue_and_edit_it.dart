import 'package:date_format/date_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:issues_reporter/controllers/bloc.dart';
import 'package:issues_reporter/controllers/functions.dart';
import 'package:issues_reporter/models/issue_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:issues_reporter/views/components/add_image_button.dart';
import 'package:issues_reporter/views/components/add_location_button.dart';
import 'package:issues_reporter/views/components/custom_inputfield.dart';
import 'package:issues_reporter/views/components/missing_data_dialog.dart';
import 'package:issues_reporter/views/components/row_of_radios.dart';
import 'package:issues_reporter/views/components/show_issue_data.dart';
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

  void setPicture(XFile? pic) {
    newPicture = pic;
  }

  void setNewStatus(String newValue) {
    newStatus = newValue;
  }

  void setPosition(CameraPosition cameraPosition) {
    longitude = cameraPosition.target.longitude.toString();
    latitude = cameraPosition.target.latitude.toString();
  }

  void setPositionToNull() {
    longitude = null;
    latitude = null;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Scaffold(
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
                          if (validate(
                              newTitle.text, newPicture, newDescription.text)) {
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
                                latitude,
                                longitude));
                            Navigator.pop(context);
                          } else {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) =>
                                    const MissingDataDialog());
                          }
                        })
                  ]),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: editingMode == false
                    ? ShowIssueData(widget.issue)
                    : Column(children: [
                        CustomInputField(
                            controller: newTitle,
                            maxLines: 1,
                            hint: 'Enter New Title'),
                        CustomInputField(
                            controller: newDescription,
                            hint: 'Enter new description',
                            maxLines: 3),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RadioButtons(
                                valueGet: newStatus, valueSet: setNewStatus)),
                        AddLocationButton(
                            positionSetter: setPosition,
                            positionSetterToNull: setPositionToNull,
                            lat: latitude,
                            lon: longitude),
                        AddImageButton(
                            picture: newPicture, picSetter: setPicture)
                      ]))));
  }
}
