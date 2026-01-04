import 'package:booking/types/apartment_type.dart';

class ApiApartmentStates {
  final ApartmentType apartment;
  final String? message;
  final List<int> deleteImage;

  ApiApartmentStates({
    required this.apartment,
    required this.message,
    required this.deleteImage,
  });
}

class ApiApartmentInitial extends ApiApartmentStates {
  ApiApartmentInitial({
    required super.apartment,
    required super.message,
    required super.deleteImage,
  });
}

class ApiApartmentLoading extends ApiApartmentStates {
  ApiApartmentLoading({
    required super.apartment,
    required super.message,
    required super.deleteImage,
  });
}

class ApiApartmentSuccefulAdd extends ApiApartmentStates {
  ApiApartmentSuccefulAdd({
    required super.apartment,
    required super.message,
    required super.deleteImage,
  });
}

class ApiApartmentSuccefulDelete extends ApiApartmentStates {
  ApiApartmentSuccefulDelete({
    required super.apartment,
    required super.message,
    required super.deleteImage,
  });
}

class ApiApartmentFaild extends ApiApartmentStates {
  ApiApartmentFaild({
    required super.apartment,
    required super.message,
    required super.deleteImage,
  });
}
