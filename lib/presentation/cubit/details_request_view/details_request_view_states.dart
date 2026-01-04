import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_register_type.dart';

class DetailsRequestViewStates {
  final ApartmentType? apartment;
  final UserRegisterType? user;
  final String? message;

  DetailsRequestViewStates({required this.apartment, required this.user, required this.message});
}

class DetailsRequestViewInitial extends DetailsRequestViewStates {
  DetailsRequestViewInitial({required super.apartment, required super.user, required super.message});
}

class DetailsRequestViewLoading extends DetailsRequestViewStates {
  DetailsRequestViewLoading({required super.apartment, required super.user, required super.message});
}

class DetailsRequestViewSuccessful extends DetailsRequestViewStates {
  DetailsRequestViewSuccessful({required super.apartment, required super.user, required super.message});
}

class DetailsRequestViewFaild extends DetailsRequestViewStates {
  DetailsRequestViewFaild({required super.apartment, required super.user, required super.message});
}
