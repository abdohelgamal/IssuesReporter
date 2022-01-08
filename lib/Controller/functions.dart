import 'package:image_picker/image_picker.dart';

bool validate(String title, XFile? picture, String description) {
  if (title != '' && picture != null && description != '') {
    return true;
  } else {
    return false;
  }
}
