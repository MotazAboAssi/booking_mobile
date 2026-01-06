import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/types/image_from_apartment.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperImage extends StatelessWidget {
  final List<ImageFromApartment>? images;
  const SwiperImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemWidth: double.infinity,
      itemCount: images?.length ?? 0,
      loop: true,
      autoplay: true,
      duration: 500,
      layout: SwiperLayout.CUSTOM,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        ..addTranslate([
          const Offset(0, 0),
          const Offset(0, 0),
          const Offset(0, 0),
        ])
        ..addOpacity([0.0, 1.0, 0.0]),
      itemBuilder: (context, index) {
        return ClipRRect(
          // borderRadius: BorderRadius.circular(16),
          child: Image(
            image: fetchImageFromDB(images?[index].image ?? ""),
            fit: BoxFit.fill,
          ),
        );
      },
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: context.appTheme.thirdly,
          activeColor: context.appTheme.fourthly,
        ),
      ),
    );
  }
}
