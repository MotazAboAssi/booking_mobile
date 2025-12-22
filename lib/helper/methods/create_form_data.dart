import 'package:booking/types/image_from_apartment.dart';
import 'package:dio/dio.dart';

Future<FormData> createFormData(
  List<ImageFromApartment> files,
  Map<String, dynamic> otherFields,
) async {
  List<MultipartFile> multipartFiles = [];

  for (var file in files) {
    multipartFiles.add(await MultipartFile.fromFile(file.image));
  }

  return FormData.fromMap({...otherFields, "images": multipartFiles});
}
