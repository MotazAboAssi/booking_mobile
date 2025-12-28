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
    return FilterType(
      city: json['city'],
      town: json['town'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      minRooms: 0,
      maxRooms: json['rooms'],
      minSpace: json['min-space'],
      maxSpace: json['max-space'],
      minRating: json['min_rating'],
    );
  }
}
