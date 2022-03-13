import 'package:image_picker/image_picker.dart';

///A model for Issues to use them as objects
class Issue {
  final int id;
  final String title;
  final XFile picture;
  final String description;
  final String date;
  final String status;

  Issue(this.id, this.title, this.picture, this.description, this.date,
      this.status);
}
