import 'package:booking/types/filter_type.dart';

class FilterViewStates {
  final List<FilterType> filter;
  final String? message;

  FilterViewStates({required this.filter, required this.message});
}

class FilterViewInitial extends FilterViewStates {
  FilterViewInitial({required super.filter, required super.message});
}

class FilterViewLoading extends FilterViewStates {
  FilterViewLoading({required super.filter, required super.message});
}

class FilterViewSuccessful extends FilterViewStates {
  FilterViewSuccessful({required super.filter, required super.message});
}

class FilterViewFaild extends FilterViewStates {
  FilterViewFaild({required super.filter, required super.message});
}
