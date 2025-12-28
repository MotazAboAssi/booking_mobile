import 'package:booking/types/apartment_type.dart';

class FetchApartmentStates {
  final ApartmentType apartment;
  final String? message;

  FetchApartmentStates({required this.apartment, required this.message});
}

class FetchApartmentInitial extends FetchApartmentStates{
  FetchApartmentInitial({required super.apartment, required super.message});
}

class FetchApartmentLoading extends FetchApartmentStates{
  FetchApartmentLoading({required super.apartment, required super.message});
}

class FetchApartmentSuccessful extends FetchApartmentStates{
  FetchApartmentSuccessful({required super.apartment, required super.message});
}

class FetchApartmentFaild extends FetchApartmentStates{
  FetchApartmentFaild({required super.apartment, required super.message});
}
