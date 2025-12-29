class RateType {
  final int? overallExperlence;
  final int? cleanLess;
  final int? location;
  final int? communication;
  final int? value;
  final String? comment;
  final int? rate;

  RateType({
    required this.comment,
    required this.rate,
    this.overallExperlence,
    this.cleanLess,
    this.location,
    this.communication,
    this.value,
  });

  factory RateType.fromJson(Map<String, dynamic> json) {
    return RateType(comment: json['connemt'], rate: json['rate']);
  }
}
