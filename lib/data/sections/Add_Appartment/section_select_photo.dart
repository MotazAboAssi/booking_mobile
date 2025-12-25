import 'dart:ui' as border_type;

import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/add_apartment_view/add_apartment_cubit.dart';
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
  final List<File> selectedImages = [];
  Future pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(imageQuality: 80);
    if (picked.isEmpty) return;

    setState(() {
      selectedImages.addAll(picked.map((e) => File(e.path)));
    });
  }

  @override
  Widget build(BuildContext context) {
    printGreen(selectedImages.toString());
    final double radiusCircul = 2;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(rem(1)),
          child: InkWell(
            onTap: () async {
              try {
                await pickImages();

                ApartmentType apartment = BlocProvider.of<AddApartmentCubit>(
                  context,
                ).state.apartment;
                for (int i = 0; i < selectedImages.length; i++) {
                  apartment.images.add(
                    ImageFromApartment(
                      id: -1,
                      idApartment: -1,
                      image: selectedImages[i].path,
                    ),
                  );
                }
                print("object");
                print(apartment.images);
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
                          "Upload at least 5 photos of your apartment",
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
          height: selectedImages.isEmpty ? 0 : 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
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
                                  BlocProvider.of<AddApartmentCubit>(
                                    context,
                                  ).state.apartment;
                              apartment.images.removeAt(index);
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
