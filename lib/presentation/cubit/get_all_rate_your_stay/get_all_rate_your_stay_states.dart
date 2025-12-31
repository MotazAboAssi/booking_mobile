import 'package:booking/types/rate_type.dart';

class GetAllRateYourStayStates {
  final List<RateType> rates;
  final String? message;

  GetAllRateYourStayStates({required this.message, required this.rates});
}

class GetAllRateYourStayInitial extends GetAllRateYourStayStates {
  GetAllRateYourStayInitial({required super.message, required super.rates});
}

class GetAllRateYourStayLoading extends GetAllRateYourStayStates {
  GetAllRateYourStayLoading({required super.message, required super.rates});
}

class GetAllRateYourStaySuccessful extends GetAllRateYourStayStates {
  GetAllRateYourStaySuccessful({required super.message, required super.rates});
}

class GetAllRateYourStayFaild extends GetAllRateYourStayStates {
  GetAllRateYourStayFaild({required super.message, required super.rates});
}
