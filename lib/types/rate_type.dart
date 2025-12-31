import 'package:booking/helper/test/print.dart';

class RateType {
  int? overallExperlence;
  int? cleanLess;
  int? location;
  int? communication;
  int? value;
  String? comment;
  int? rate;
  final int userid;
  final int apartmentid;
  final DateTime createdAt;

  RateType({
    required this.comment,
    required this.rate,
    this.overallExperlence,
    this.cleanLess,
    this.location,
    this.communication,
    this.value,
    required this.userid,
    required this.apartmentid,
    required this.createdAt,
  });

  factory RateType.fromJson(Map<String, dynamic> json) {
    // final json = data['review'];
    printGreen(json.toString());
    return RateType(
      comment: json['comment'],
      rate: json['rate'] == null ? null : int.parse(json['rate']),
      userid: json['user_id'],
      apartmentid: json['apartment_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  factory RateType.empty() {
    return RateType(
      comment: null,
      rate: null,
      userid: -1,
      apartmentid: -1,
      createdAt: DateTime(0, 0, 0),
    );
  }
}
