import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/image_from_apartment.dart';
import 'package:flutter/material.dart';
import 'package:booking/helper/keys_localization/landlord_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SectionSelectPhoto extends StatefulWidget {
  const SectionSelectPhoto({super.key});

  @override
  State<SectionSelectPhoto> createState() => _SectionSelectPhotoState();
}

class _SectionSelectPhotoState extends State<SectionSelectPhoto>
    with AutomaticKeepAliveClientMixin {
  List<File> selectedImages = [];

  Future pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;
    setState(() {
      selectedImages.addAll(picked.map((e) => File(e.path)));
    });
  }

  List<int> deleteImage = [];
  ApartmentType? apartmentCopy;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      apartmentCopy =
          (ModalRoute.of(context)!.settings.arguments as Map)['apartment'];
    }
    final double radiusCircul = 2;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(rem(1)),
          child: InkWell(
            onTap: () async {
              try {
                await pickImages(context);

                BlocProvider.of<ApiApartmentCubit>(
                  context,
                ).state.apartment.images!.addAll(
                  selectedImages.map(
                    (e) => ImageFromApartment(
                      id: -1,
                      idApartment: -1,
                      image: e.path,
                    ),
                  ),
                );
              } catch (e) {
                printRed(e.toString());
              }
            },
            child: UIAddPictures(radiusCircul: radiusCircul),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: DisplayImages(
            apartmentCopy: apartmentCopy,
            selectedImages: selectedImages,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class UIAddPictures extends StatelessWidget {
  const UIAddPictures({super.key, required this.radiusCircul});

  final double radiusCircul;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(rem(1.4)),
        color: context.appTheme.fourthly,
        strokeWidth: 2,
        dashPattern: [6, 4],
        padding: EdgeInsets.all(3),
      ),
      child: AspectRatio(
        aspectRatio: 2,
        child: Container(
          decoration: BoxDecoration(
            color: context.appTheme.fourthly.withAlpha(128),
            borderRadius: BorderRadius.circular(rem(1.4)),
          ),
          child: Center(
            child: Column(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: rem(radiusCircul - 0.5),
                  backgroundColor: context.appTheme.fourthly,
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: context.appTheme.thirdly,
                    size: rem(radiusCircul),
                  ),
                ),
                Text(
                  LandlordKeys.addPhotosLabel.tr(),
                  style: TextStyle(
                    fontSize: rem(1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  LandlordKeys.addPhotosInstruction.tr(),
                  style: TextStyle(
                    fontSize: rem(0.9),
                    color: context.appTheme.secondary,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(rem(0.5)),
                  decoration: BoxDecoration(
                    color: context.appTheme.fourthly,
                    borderRadius: BorderRadius.circular(rem(0.4)),
                  ),
                  child: Text(
                    LandlordKeys.addPhotosButton.tr(),
                    style: TextStyle(color: context.appTheme.thirdly),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayImages extends StatefulWidget {
  final ApartmentType? apartmentCopy;
  final List<File> selectedImages;
  const DisplayImages({
    super.key,
    required this.apartmentCopy,
    required this.selectedImages,
  });

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  @override
  Widget build(BuildContext context) {
    printGreen(
      BlocProvider.of<ApiApartmentCubit>(context).state.deleteImage.toString(),
    );
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        if (widget.apartmentCopy?.images != null &&
            widget.apartmentCopy!.images!.isNotEmpty)
          ...widget.apartmentCopy!.images!.asMap().entries.map((entry) {
            int index = entry.key;
            String url = entry.value.image;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),

                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: fetchImageFromDB(url)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          final ImageFromApartment image = widget
                              .apartmentCopy!
                              .images!
                              .removeAt(index);
                          BlocProvider.of<ApiApartmentCubit>(
                            context,
                          ).state.deleteImage.add(image.id);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.appTheme.primarye,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: context.appTheme.thirdly,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

        ...widget.selectedImages.asMap().entries.map((entry) {
          int index = entry.key;
          File file = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    file,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.selectedImages.removeAt(index);
                        BlocProvider.of<ApiApartmentCubit>(
                          context,
                        ).state.apartment.images?.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.appTheme.primarye,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: context.appTheme.thirdly,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}



    // printGreen('${deleteImage.isEmpty}');
    // if (ModalRoute.of(context)?.settings.arguments != null &&
    //     BlocProvider.of<ApiApartmentCubit>(context).state.deleteImage.isEmpty) {
    //   printWhite('copy');
    //   ApartmentType apartment =
    //       (ModalRoute.of(context)?.settings.arguments as Map)['apartment'];
    //   apartmentCopy = ApartmentType.copyFrom(apartment);
    // }
    // if (ModalRoute.of(context)?.settings.arguments != null &&
    //     BlocProvider.of<ApiApartmentCubit>(
    //       context,
    //     ).state.deleteImage.isNotEmpty) {
    //   ApartmentType apart = BlocProvider.of<ApiApartmentCubit>(
    //     context,
    //   ).state.apartment;
    //   List<ImageFromApartment>? imgs = [];
    //   for (int i = 0; i < apart.images!.length; i++) {
    //     if (!deleteImage.contains(apart.images![i].id)) {
    //       imgs.add(apart.images![i]);
    //     }
    //   }
    //   apartmentCopy?.images?.addAll(imgs);
    // }




                // for (int i = 0; i < selectedImages.length; i++) {
                //   apartmentCopy?.images!.add(
                //     ImageFromApartment(
                //       id: -1,
                //       idApartment: -1,
                //       image: selectedImages[i].path,
                //     ),
                //   );
                // }
                