import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

class AddLocationButton extends StatefulWidget {
  AddLocationButton(
      {required this.positionSetter,
      required this.positionSetterToNull,
      this.lat,
      this.lon,
      Key? key})
      : super(key: key);
  String? lat;
  String? lon;
  void Function(CameraPosition) positionSetter;
  void Function() positionSetterToNull;
  @override
  State<AddLocationButton> createState() => _AddLocationButtonState();
}

class _AddLocationButtonState extends State<AddLocationButton> {
  String? lat;
  String? lon;
  CameraPosition camPos = const CameraPosition(target: LatLng(31, 31), zoom: 5);
  MapPickerController mapController = MapPickerController();

  @override
  void initState() {
    lat = widget.lat;
    lon = widget.lon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lon == null && lat == null) {
      return TextButton.icon(
          label: const Text('Add an a location (optional)'),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: const EdgeInsets.all(40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                                  size: 30,
                                  color: Colors.red,
                                )),
                          ),
                          const Text(
                            'Please choose the location of the issue',
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            padding: const EdgeInsets.all(18),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 400,
                            child: MapPicker(
                                iconWidget: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 50,
                                ),
                                mapPickerController: mapController,
                                child: GoogleMap(
                                    onCameraMove: ((position) {
                                      camPos = position;
                                    }),
                                    onCameraIdle: () {
                                      mapController.mapFinishedMoving!();
                                    },
                                    onCameraMoveStarted: () {
                                      mapController.mapMoving!();
                                    },
                                    initialCameraPosition: camPos)),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)))),
                              onPressed: () {
                                lat = camPos.target.latitude.toString();
                                lon = camPos.target.longitude.toString();
                                widget.positionSetter(camPos);
                                Navigator.pop(context);
                              },
                              child: const Text('Choose this location'))
                        ],
                      ),
                    ),
                  );
                }).whenComplete(() {
              setState(() {});
            });
          },
          icon: const Icon(Icons.add));
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              'Current selected location is $lon , $lat',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {   lat = null;
                                lat = null;
                  widget.positionSetterToNull();
                });
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ))
        ],
      );
    }
  }
}
