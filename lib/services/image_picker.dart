import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future getImage() async {
  XFile picker = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (picker != null) {
    return File(picker.path);
  } else {
    print('No image selected.');
    return 'No selected image';
  }
}
