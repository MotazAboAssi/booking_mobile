import 'package:booking/data/models/favorite_view/favorite_apartment_button.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/back_to.dart';
import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_cubit.dart';
import 'package:booking/presentation/widgets/swiper_images.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionHeaderAndAppartementImages extends StatelessWidget {
  final ApartmentType? apartment;

  const SectionHeaderAndAppartementImages({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        apartment!.images!.isEmpty
            ? Container(
                decoration: apartment != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(anonymousManAvatar),
                        ),
                      )
                    : null,
              )
            : SwiperImage(images: apartment?.images),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: primary.withAlpha(127),
              child: BlocProvider(
                create: (BuildContext context) =>
                    ToggleFavoriteApartmentButtonCubit(),
                child: FavoriteApartmentButton(apartment: apartment),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primary.withAlpha(127),
            child: IconButton(
              onPressed: () {
                backTo(context);
              },
              icon: Icon(Icons.arrow_back, color: thirdly),
            ),
          ),
        ),
      ],
    );
  }
}
