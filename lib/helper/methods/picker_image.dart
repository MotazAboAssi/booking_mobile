import 'dart:io';

import 'package:booking/helper/test/print.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickerImage {
  File? image;

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on PlatformException catch (e) {
      printRed('Failed to pick image: $e');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
    } on PlatformException catch (e) {
      printRed('Failed to pick image: $e');
    }
  }
}
