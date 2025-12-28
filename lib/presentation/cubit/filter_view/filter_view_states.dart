import 'package:booking/types/apartment_type.dart';

class FilterViewStates {
  final List<ApartmentType> resFilter;
  final String? message;

  FilterViewStates({required this.resFilter, required this.message});
}

class FilterViewInitial extends FilterViewStates {
  FilterViewInitial({required super.resFilter, required super.message});
}

class FilterViewLoading extends FilterViewStates {
  FilterViewLoading({required super.resFilter, required super.message});
}

class FilterViewSuccessful extends FilterViewStates {
  FilterViewSuccessful({required super.resFilter, required super.message});
}

class FilterViewFaild extends FilterViewStates {
  FilterViewFaild({required super.resFilter, required super.message});
}
