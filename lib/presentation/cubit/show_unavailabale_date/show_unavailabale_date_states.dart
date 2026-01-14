import 'package:booking/types/range_unavailable_date.dart';

class ShowUnavailabaleDateStates {}

class ShowUnavailabaleDateInitial extends ShowUnavailabaleDateStates {}

class ShowUnavailabaleDateLoading extends ShowUnavailabaleDateStates {}

class ShowUnavailabaleDateSuccessful extends ShowUnavailabaleDateStates {
  final List<RangeUnavailableDate> unavailableDates;
  ShowUnavailabaleDateSuccessful(this.unavailableDates);
}

class ShowUnavailabaleDateFailed extends ShowUnavailabaleDateStates {
  final String message;
  ShowUnavailabaleDateFailed(this.message);
}
