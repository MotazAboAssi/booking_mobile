import 'package:flutter/material.dart';

abstract class ToggleColorStates {}

class ToggleColorLoading extends ToggleColorStates {}

class ToggleColorInitial extends ToggleColorStates {
  final ThemeMode mode;
  ToggleColorInitial({required this.mode});
}

class ToggleColorSuccessful extends ToggleColorStates {
  final ThemeMode mode;
  ToggleColorSuccessful({required this.mode});
}

class ToggleColorFailed extends ToggleColorStates {
  final ThemeMode mode;
  final String message;

  ToggleColorFailed({required this.mode, required this.message});
}
