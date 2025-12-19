import 'dart:ui' as border_type;

import 'package:booking/helper/constant/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SectionSelectPhoto extends StatefulWidget {
  const SectionSelectPhoto({super.key});

  @override
  State<SectionSelectPhoto> createState() => _SectionSelectPhotoState();
}

class _SectionSelectPhotoState extends State<SectionSelectPhoto> {
  // للـ Mobile
  final List<File> selectedImages = [];

  // للـ Web
  final List<Uint8List> webImages = [];

  Future pickImages() async {
    final picker = ImagePicker();

    if (kIsWeb) {
      final picked = await picker.pickMultiImage(imageQuality: 80);
      if (picked.isEmpty) return;

      List<Uint8List> temp = [];
      for (var file in picked) {
        final bytes = await file.readAsBytes();
        temp.add(bytes);
      }

      setState(() {
        webImages.addAll(temp);
      });
    } else {
      final picked = await picker.pickMultiImage(imageQuality: 80);
      if (picked.isEmpty) return;

      setState(() {
        selectedImages.addAll(picked.map((e) => File(e.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: pickImages,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12),
                color: primary,
                strokeWidth: 2,
                dashPattern: [6, 4],
                padding: EdgeInsets.all(3),
              ),
              child: Container(
                color: const Color.fromARGB(255, 172, 217, 238),
                height: 150,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_photo_alternate,
                        color: border_type.Color.fromARGB(255, 59, 56, 245),
                        size: 40,
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Add Photos",
                        style: TextStyle(color: primary, fontSize: 16),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Ubload at least 5 photos of your apartment",
                        style: TextStyle(color: primary, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: selectedImages.isEmpty && webImages.isEmpty ? 0 : 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // صور Mobile
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
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImages.removeAt(index);
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
              // صور Web
              ...webImages.asMap().entries.map((entry) {
                int index = entry.key;
                Uint8List bytes = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          bytes,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              webImages.removeAt(index);
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
}
