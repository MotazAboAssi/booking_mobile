import 'package:booking/helper/test/print.dart';
import 'package:booking/types/apartment_with_booking_type.dart';

enum BookingStatus { pending, confirmed, canceled }

class BookingApartmentType {
  final DateTime startDate;
  final DateTime endDate;
  final int userID;
  final int apartmentID;
  final int bookingID;
  final int totalCost;
  final BookingStatus status;
  final ApartmentWithBookingType apartment;

  BookingApartmentType({
    required this.startDate,
    required this.endDate,
    required this.userID,
    required this.apartmentID,
    required this.totalCost,
    required this.bookingID,
    required this.status,
    required this.apartment,
  });

  factory BookingApartmentType.fromJson(Map<String, dynamic> json) {
    printGrey(json.toString());
    // final ApartmentWithBookingType apartment = ApartmentWithBookingType.fromJsonWithoutFivorite(json['apartment']);
    return BookingApartmentType(
      bookingID: json['id'],
      userID: json['user_id'],
      apartmentID: json['apartment_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalCost: json['total_cost'],
      apartment: json['apartment'] == null
          ? ApartmentWithBookingType.empty()
          : ApartmentWithBookingType.fromJsonWithoutFivorite(json['apartment']),
      status: json['status'] == 'pending'
          ? BookingStatus.pending
          : json['status'] == 'confirmed'
          ? BookingStatus.confirmed
          : BookingStatus.canceled,
    );
  }

  factory BookingApartmentType.empty() {
    // final ApartmentType apartment = ApartmentType.fromJson(json['apartment']);
    return BookingApartmentType(
      bookingID: 0,
      userID: 0,
      apartmentID: 0,
      startDate: DateTime(2025, 12, 27),
      endDate: DateTime(2025, 12, 28),
      totalCost: 0,
      status: BookingStatus.confirmed,
      apartment: ApartmentWithBookingType.empty(),
    );
  }
}
