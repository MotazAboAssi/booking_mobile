import 'package:booking/types/apartment_type.dart';

class FetchAllApartmentForLandlordStates {
  final List<ApartmentType> apartments;
  final String? message;

  FetchAllApartmentForLandlordStates({required this.apartments, required this.message});
}

class FetchAllApartmentForLandlordInitial extends FetchAllApartmentForLandlordStates {
  FetchAllApartmentForLandlordInitial({required super.apartments, required super.message});
}
class FetchAllApartmentForLandlordLoading extends FetchAllApartmentForLandlordStates {
  FetchAllApartmentForLandlordLoading({required super.apartments, required super.message});
}
class FetchAllApartmentForLandlordSuccessful extends FetchAllApartmentForLandlordStates {
  FetchAllApartmentForLandlordSuccessful({required super.apartments, required super.message});
}
class FetchAllApartmentForLandlordFaild extends FetchAllApartmentForLandlordStates {
  FetchAllApartmentForLandlordFaild({required super.apartments, required super.message});
}
