class RateType {
  final int? rate;
  final String? comment;

  RateType({required this.rate, required this.comment});

  factory RateType.fromJson(Map<String, dynamic> json) {
    return RateType(rate: json['rate'], comment: json['comment']);
  }
}
