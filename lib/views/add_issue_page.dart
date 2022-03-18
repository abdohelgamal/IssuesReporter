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
import 'package:issues_reporter/views/components/custom_textfield.dart';
import 'package:issues_reporter/views/components/missing_data_dialog.dart';
import 'package:issues_reporter/views/components/row_of_radios.dart';

///This Page is for entering a new [Issue] and its details
class AddIssuePage extends StatefulWidget {
  const AddIssuePage({Key? key}) : super(key: key);

  @override
  State<AddIssuePage> createState() => _AddIssuePageState();
}

class _AddIssuePageState extends State<AddIssuePage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String status = 'Open';
  String? longitude;
  String? latitude;
  XFile? picture;

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  void setPosition(CameraPosition cameraPosition) {
    longitude = cameraPosition.target.longitude.toString();
    latitude = cameraPosition.target.latitude.toString();
  }

  void setPositionToNull() {
    longitude = null;
    latitude = null;
  }

  void setStatus(String newValue) {
    status = newValue;
  }

  void setPicture(XFile? pic) {
    picture = pic;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<BlocForIssues>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 245, 120, 82),
          child: const Icon(Icons.add, size: 30),
          onPressed: () {
            if (validate(title.text, picture, description.text)) {
              bloc.addNewIssue(Issue(
                  1,
                  title.text,
                  picture!.path,
                  description.text,
                  formatDate(DateTime.now(),
                      [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn]),
                  status,
                  latitude,
                  longitude));
              Navigator.pop(context);
            } else {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => const MissingDataDialog());
            }
          },
        ),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 245, 120, 82),
            title: const Text('Please enter issue details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CustomInputField(title: title, maxLines: 1, hint: 'Title :'),
            CustomInputField(
                title: description, maxLines: 3, hint: 'Description :'),
            RadioButtons(valueGet: status, valueSet: setStatus),
            AddLocationButton(
                positionSetter: setPosition,
                positionSetterToNull: setPositionToNull),
            AddImageButton(
              picture: picture,
              picSetter: setPicture,
            )
          ]),
        ))));
  }
}
