import 'package:image_picker/image_picker.dart';
import 'package:issues_reporter/models/issue_class.dart';

///Validates the inputs of the data of the [Issue] that they are correct and not null
bool validate(String title, XFile? picture, String description) {
  if (title != '' && picture != null && description != '') {
    return true;
  } else {
    return false;
  }
}
