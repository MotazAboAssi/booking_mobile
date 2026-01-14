import 'package:booking/data/sections/Add_Appartment/basic_datails.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/locale/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:booking/data/sections/Add_Appartment/section_select_photo.dart';
import 'package:booking/helper/keys_localization/landlord_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddApartmentBody extends StatelessWidget {
  const AddApartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              LandlordKeys.addPhotosTitle.tr(),
              style: TextStyle(fontSize: rem(1.4), fontWeight: FontWeight.bold),
            ),
          ),
          SectionSelectPhoto(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              LandlordKeys.BasicDetails.tr(),
              style: TextStyle(fontSize: rem(1.4), fontWeight: FontWeight.bold),
            ),
          ),
          BasicDatails(),
        ],
      ),
    );
  }
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
