import 'dart:ui' as border_type;

import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_cubit.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/image_from_apartment.dart';
import 'package:flutter/material.dart';
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
    // final ApartmentType? apartment =
    //     (ModalRoute.of(context)?.settings.arguments as Map)['apartment'];
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(imageQuality: 80);
    // printBlueWithBold(' imaged: ${(apartment?.images?.length)}');
    if (picked.isEmpty) return;
    // if (apartment?.images != null &&
    //     selectedImages.length != apartment!.images!.length) {
    // setState(() {
    //   selectedImages = apartment.images!
    //       .map((image) => fetchImageFromDB(image.image))
    //       .cast<File>()
    //       .toList();
    // });
    // return;
    // }

    setState(() {
      printRed(picked[0].path);
      selectedImages.addAll(picked.map((e) => File(e.path)));
    });
  }

  List<int> deleteImage = [];

  @override
  Widget build(BuildContext context) {
    ApartmentType? apartment = null;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      apartment =
          (ModalRoute.of(context)?.settings.arguments as Map)['apartment'];
    }

    printGreen(selectedImages.toString());
    final double radiusCircul = 2;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(rem(1)),
          child: InkWell(
            onTap: () async {
              try {
                await pickImages(context);
                ApartmentType apartment = BlocProvider.of<ApiApartmentCubit>(
                  context,
                ).state.apartment;
                apartment.images = [];
                if (apartment.images != null) {
                  for (int i = 0; i < apartment.images!.length; i++) {
                    apartment.images!.add(
                      ImageFromApartment(
                        id: apartment.images![i].id,
                        idApartment: apartment.images![i].idApartment,
                        image: apartment.images![i].image,
                      ),
                    );
                  }
                }
                for (int i = 0; i < selectedImages.length; i++) {
                  apartment.images!.add(
                    ImageFromApartment(
                      id: -1,
                      idApartment: -1,
                      image: selectedImages[i].path,
                    ),
                  );
                }
              } catch (e) {
                printRed(e.toString());
              }
            },
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(rem(1.4)),
                color: fourthly,
                strokeWidth: 2,
                dashPattern: [6, 4],
                padding: EdgeInsets.all(3),
              ),
              child: AspectRatio(
                aspectRatio: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: fourthly.withAlpha(128),
                    borderRadius: BorderRadius.circular(rem(1.4)),
                  ),
                  child: Center(
                    child: Column(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: rem(radiusCircul - 0.5),
                          backgroundColor: fourthly.shade700,
                          child: Icon(
                            Icons.add_photo_alternate,
                            color: thirdly,
                            size: rem(radiusCircul),
                          ),
                        ),
                        Text(
                          "Add Photos",
                          style: TextStyle(
                            fontSize: rem(1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Upload at more 5 photos of your apartment",
                          style: TextStyle(
                            fontSize: rem(0.9),
                            color: const border_type.Color.fromARGB(
                              255,
                              92,
                              92,
                              92,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(rem(0.5)),
                          decoration: BoxDecoration(
                            color: fourthly.shade700,
                            borderRadius: BorderRadius.circular(rem(0.4)),
                          ),
                          child: Text(
                            "Uplaod",
                            style: TextStyle(color: thirdly),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (apartment?.images != null)
                ...apartment!.images!.asMap().entries.map((entry) {
                  int index = entry.key;
                  // File file = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: fetchImageFromDB(entry.value.image),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                final ImageFromApartment? image = apartment
                                    ?.images
                                    ?.removeAt(index);

                                final List<int> deleteImage =
                                    BlocProvider.of<ApiApartmentCubit>(
                                      context,
                                    ).state.deleteImage;
                                deleteImage.add(image!.id);
                                printGreen(deleteImage.toString());
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ...selectedImages.asMap().entries.map((entry) {
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
                              selectedImages.removeAt(index);

                              ApartmentType apartment =
                                  BlocProvider.of<ApiApartmentCubit>(
                                    context,
                                  ).state.apartment;
                              apartment.images!.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
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
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
