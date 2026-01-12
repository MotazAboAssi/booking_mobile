import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  // Set initial locale (English)
  LocaleCubit() : super(const Locale('en'));

  void toggleLanguage(BuildContext context) {
    if (state.languageCode == 'en') {
      const newLocale = Locale('ar');
      context.setLocale(newLocale); // Easy Localization Extension
      emit(newLocale);
    } else {
      const newLocale = Locale('en');
      context.setLocale(newLocale); // Easy Localization Extension
      emit(newLocale);
    }
  }
}