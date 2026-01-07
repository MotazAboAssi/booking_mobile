class ApartmentUnavailableDate {
  final int bookID;
  final int apartmentID;
  final DateTime startNonAvailableDate;
  final DateTime endNonAvailableDate;

  ApartmentUnavailableDate({
    required this.bookID,
    required this.apartmentID,
    required this.startNonAvailableDate,
    required this.endNonAvailableDate,
  });

  factory ApartmentUnavailableDate.fromJson(Map<String, dynamic> json) {
    return ApartmentUnavailableDate(
      bookID: json['id'],
      apartmentID: json['apartment_id'],
      startNonAvailableDate: DateTime.parse(json['start_non_available_date']),
      endNonAvailableDate: DateTime.parse(json['end_non_available_date']),
    );
  }
}
