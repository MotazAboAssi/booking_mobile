import 'package:booking/data/models/auth/form/custom_snak_bar.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_cubit.dart';
import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_states.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteApartmentButton extends StatelessWidget {
  const FavoriteApartmentButton({super.key, this.apartment});
  final ApartmentType? apartment;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ToggleFavoriteApartmentButtonCubit,
      ToggleFavoriteApartmentButtonStates
    >(
      builder: (BuildContext context, state) {
        if (state is ToggleFavoriteApartmentButtonLoading) {
          return CircleAvatar(
            backgroundColor: context.appTheme.primary.withAlpha(125),
            child: Center(
              child: SizedBox(
                width: rem(1),
                height: rem(1),
                child: CircularProgressIndicator(
                  color: context.appTheme.thirdly,
                ),
              ),
            ),
          );
        }

        return InkWell(
          onTap: () async {
            final ToggleFavoriteApartmentButtonCubit cubit =
                BlocProvider.of<ToggleFavoriteApartmentButtonCubit>(context);
            await cubit.toggle(apartment!.idApartment);
            apartment!.isFavorite = !(apartment!.isFavorite ?? false);
          },
          child: CircleAvatar(
            backgroundColor: context.appTheme.primary.withAlpha(125),
            child: Center(
              child: Icon(
                Icons.favorite,
                color: apartment?.isFavorite ?? false
                    ? const Color.fromARGB(255, 255, 17, 0)
                    : context.appTheme.thirdly,
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state is ToggleFavoriteApartmentButtonFaild) {
          customSnakBar(
            margin: EdgeInsets.only(bottom: rem(4)),
            context: context,
            color: context.appTheme.error,
            message: state.message!,
          );
        }
      },
    );
  }
}
