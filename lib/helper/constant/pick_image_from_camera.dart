import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromCamera(ImagePicker picker) async {
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
  return pickedImage;
}
