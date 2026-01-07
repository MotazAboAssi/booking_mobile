import 'package:flutter/material.dart';

class ToggleColorStates {
  final ThemeMode? mode;

  ToggleColorStates({required this.mode});
}

class ToggleColorLoading extends ToggleColorStates {
  ToggleColorLoading({required super.mode});
}

class ToggleColorInitial extends ToggleColorStates {
  ToggleColorInitial({required super.mode});
}

class ToggleColorSuccessful extends ToggleColorStates {
  ToggleColorSuccessful({required super.mode});
}

class ToggleColorFailed extends ToggleColorStates {
  final String? message;
  ToggleColorFailed({required super.mode, this.message});
}
