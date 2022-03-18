import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissingDataDialog extends StatelessWidget {
  const MissingDataDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        content: const Text('Please enter all missing data and a picture',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'))
        ]);
  }
}
