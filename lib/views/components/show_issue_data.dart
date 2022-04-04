import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:issues_reporter/models/issue_class.dart';

class ShowIssueData extends StatelessWidget {
  ShowIssueData(this.issue, {Key? key}) : super(key: key);

  Issue issue;
  TextStyle txtStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Issue Id : ${issue.id}', style: txtStyle),
            Text('Issue Title : ${issue.title}', style: txtStyle),
            Text('Issue Description : ${issue.description}', style: txtStyle),
            Text('Issue Status : ${issue.status}', style: txtStyle),
            Text('Issue Date : ${issue.date}', style: txtStyle)
          ]),
      if (issue.latitude != null && issue.longitude != null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 300,
              child: GoogleMap(
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                      zoom: 8,
                      target: LatLng(double.parse(issue.latitude!),
                          double.parse(issue.longitude!)))),
            ),
          ),
        )
      else
        Text('No location', style: txtStyle),
      Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Image.file(File(issue.picturePath),
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.6)))
    ]);
  }
}
