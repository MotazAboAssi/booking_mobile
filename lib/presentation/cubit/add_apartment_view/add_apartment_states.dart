import 'package:booking/types/apartment_type.dart';

class AddApartmentStates {
   ApartmentType apartment = ApartmentType.empty();
}

class InitialAddApartment extends AddApartmentStates {}

class AddApartmentLoading extends AddApartmentStates {}

class AddApartmentSuccessful extends AddApartmentStates {}

class AddApartmentFaild extends AddApartmentStates {
  final String error;
  AddApartmentFaild({required this.error});
}
