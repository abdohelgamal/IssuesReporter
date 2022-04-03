import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///This component widget handles the part of adding an [Image] and rebuilding its state according to the changes
class AddImageButton extends StatefulWidget {
  AddImageButton({required this.picture, required this.picSetter, Key? key})
      : super(key: key);
  XFile? picture;
  void Function(XFile?) picSetter;
  @override
  State<AddImageButton> createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
  XFile? picture;

  @override
  void initState() {
    picture = widget.picture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (picture == null) {
      return TextButton.icon(
          label: const Text('Add an image'),
          onPressed: () async {
            ImagePicker imagePicker = ImagePicker();
            final XFile? photo =
                await imagePicker.pickImage(source: ImageSource.camera);
            if (photo is XFile) {
              widget.picSetter(photo);
              setState(() {
                picture = photo;
              });
            } else {
              return;
            }
          },
          icon: const Icon(Icons.add));
    } else {
      return Stack(
        children: [
          Image.file(File(picture!.path),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover),
          IconButton(
              onPressed: () {
                widget.picSetter(null);
                setState(() {
                  picture = null;
                });
              },
              color: Colors.white,
              iconSize: 35,
              icon: const Icon(Icons.cancel_rounded))
        ],
        alignment: Alignment.topRight,
      );
    }
  }
}
