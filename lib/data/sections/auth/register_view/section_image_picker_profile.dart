import 'dart:io';

import 'package:booking/helper/constant/images.dart';
import 'package:booking/helper/constant/pick_image_from_camera.dart';
import 'package:booking/helper/constant/pick_image_from_gallery.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/alert_dialog.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SectionImagePickerProfile extends StatefulWidget {
  const SectionImagePickerProfile({
    super.key,
    required this.constraints,
    required this.fun,
  });

  final BoxConstraints constraints;
  final VoidCallBackFile fun;

  @override
  State<SectionImagePickerProfile> createState() =>
      _SectionImagePickerProfileState();
}

class _SectionImagePickerProfileState extends State<SectionImagePickerProfile> {
  final ImagePicker imagePicker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    const double radiusProfile = 4;
    const double radiusIcon = 1.3;
    return Column(
      children: [
        Stack(
          children: [
            Align(
              child: CircleAvatar(
                radius: rem(radiusProfile),
                backgroundColor: context.appTheme.primarye,
                child: CircleAvatar(
                  radius: rem(radiusProfile - 0.1),
                  backgroundImage: image == null
                      ? AssetImage(anonymousManAvatar)
                      : FileImage(image!),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: widget.constraints.maxWidth * 0.3,
              child: CircleAvatar(
                backgroundColor: context.appTheme.thirdly,
                radius: rem(radiusIcon + 0.1),
                child: CircleAvatar(
                  backgroundColor: context.appTheme.fourthly,
                  radius: rem(radiusIcon - 0.1),
                  child: InkWell(
                    onTap: () async {
                      XFile? imageFromSource;
                      await showAlertDialog(context, imagePicker, (ch) async {
                        if (ch == 0) {
                          imageFromSource = await pickImageFromGallery(
                            imagePicker,
                          );
                        } else {
                          imageFromSource = await pickImageFromCamera(
                            imagePicker,
                          );
                        }
                      });

                      if (imageFromSource != null) {
                        setState(() {
                          image = File(imageFromSource!.path);
                        });
                        widget.fun(image);
                      }
                    },
                    child: Icon(
                      Icons.add_a_photo,
                      color: context.appTheme.thirdly,
                      size: rem(radiusIcon * 1.1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            AuthKeys.profileActionText.tr(),
            style: TextStyle(fontSize: rem(1), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
