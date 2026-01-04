class ConfirmBookStates {}

class ConfirmBookIntial extends ConfirmBookStates {}

class ConfirmBookLoading extends ConfirmBookStates {}

class ConfirmBookSuccessful extends ConfirmBookStates {
  final String? message;

  ConfirmBookSuccessful({required this.message});
}

class ConfirmBookFaild extends ConfirmBookStates {
  final String? message;

  ConfirmBookFaild({required this.message});
}
