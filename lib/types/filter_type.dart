import 'package:booking/helper/test/print.dart';

class FilterType {
  final String? city;
  final String? town;
  final int? minPrice;
  final int? maxPrice;
  final int? minRooms;
  final int? maxRooms;
  final int? minSpace;
  final int? maxSpace;
  final int? minRating;

  FilterType({
    required this.city,
    required this.town,
    required this.minPrice,
    required this.maxPrice,
    required this.minRooms,
    required this.maxRooms,
    required this.minSpace,
    required this.maxSpace,
    required this.minRating,
  });

  factory FilterType.fromJson(Map<String, dynamic> json) {
    printGreen(json.toString());
    return FilterType(
      city: json['city'],
      town: json['town'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      minRooms: json['min_rooms'],
      maxRooms: json['max_rooms'],
      minSpace: json['min-space'],
      maxSpace: json['max-space'],
      minRating: json['min_rating'],
    );
  }
}
