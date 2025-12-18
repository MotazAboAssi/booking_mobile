import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery(ImagePicker picker) async {
  final XFile? pickedImage = await picker.pickImage(
    source: ImageSource.gallery,
  );
  return pickedImage;
}
