enum BookingStatus { pending, confirmed, canceled }

class BookingApartmentType {
  final DateTime startDate;
  final DateTime endDate;
  final int userID;
  final int apartmentID;
  final int bookingID;
  final int totalCost;
  final BookingStatus status;

  BookingApartmentType({
    required this.startDate,
    required this.endDate,
    required this.userID,
    required this.apartmentID,
    required this.totalCost,
    required this.bookingID,
    required this.status,
  });

  factory BookingApartmentType.fromJson(Map<String, dynamic> json) {
    // final ApartmentType apartment = ApartmentType.fromJson(json['apartment']);
    return BookingApartmentType(
      bookingID: json['id'],
      userID: json['user_id'],
      apartmentID: json['apartment_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalCost: json['total_cost'],
      status: json['status'] == 'pending'
          ? BookingStatus.pending
          : json['status'] == 'confirmed'
          ? BookingStatus.confirmed
          : BookingStatus.canceled,
    );
  }
}
