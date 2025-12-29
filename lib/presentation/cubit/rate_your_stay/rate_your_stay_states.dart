import 'package:booking/types/rate_type.dart';

class RateYourStayStates {
  final RateType pov;
  final String? message;

  RateYourStayStates({required this.message, required this.pov});
}

class RateYourStayInitial extends RateYourStayStates {
  RateYourStayInitial({required super.pov, required super.message});
}

class RateYourStayLoading extends RateYourStayStates {
  RateYourStayLoading({required super.pov, required super.message});
}

class RateYourStaySuccessful extends RateYourStayStates {
  RateYourStaySuccessful({required super.pov, required super.message});
}

class RateYourStayFaild extends RateYourStayStates {
  RateYourStayFaild({required super.pov, required super.message});
}
