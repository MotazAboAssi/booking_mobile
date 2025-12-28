class BookingApartmentStates {}

class BookingApartmentInitial extends BookingApartmentStates {}
class BookingApartmentLoading extends BookingApartmentStates {}

class BookingApartmentSuccessful extends BookingApartmentStates {
  final String response;

  BookingApartmentSuccessful({required this.response});
}

class BookingApartmentFaild extends BookingApartmentStates {
  final String errorMessage;

  BookingApartmentFaild({required this.errorMessage});
}
