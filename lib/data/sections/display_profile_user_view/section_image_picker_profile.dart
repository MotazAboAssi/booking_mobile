import 'dart:io';

import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/methods/fetch_image_from_db.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class SectionImagePickerProfile extends StatelessWidget {
  final File? image;

  const SectionImagePickerProfile({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    const double radiusProfile = 4;
    return CircleAvatar(
      radius: rem(radiusProfile),
      backgroundColor: context.appTheme.primary,
      child: CircleAvatar(
        radius: rem(radiusProfile - 0.1),
        backgroundImage: image == null
            ? AssetImage(anonymousManAvatar)
            : fetchImageFromDB(image!.path),
      ),
    );
  }
}
