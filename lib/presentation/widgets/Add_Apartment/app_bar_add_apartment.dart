// import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/presentation/cubit/locale/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking/helper/keys_localization/landlord_key.dart';
import 'package:easy_localization/easy_localization.dart';

AppBar addApartmentAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      LandlordKeys.addApartmentTitle.tr(),
      style: TextStyle(fontSize: rem(1)),
    ),
    centerTitle: true,
  );
}

class ButtonLocalization extends StatelessWidget {
  const ButtonLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            BlocProvider.of<LocaleCubit>(context).toggleLanguage(context);
          },
          icon: Icon(Icons.language, color: context.appTheme.primarye),
        );
      },
    );
  }
}
