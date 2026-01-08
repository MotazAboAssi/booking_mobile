import 'dart:io';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/constant/pick_image_from_camera.dart';
import 'package:booking/helper/constant/pick_image_from_gallery.dart';
import 'package:booking/helper/methods/alert_dialog.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/main.dart';
import 'package:booking/presentation/widgets/auth/register_view/case_not_upload_image.dart';
import 'package:booking/presentation/widgets/auth/register_view/case_upload_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SectionPickImagePictureID extends StatefulWidget {
  const SectionPickImagePictureID({super.key, required this.fun});

  final VoidCallBackFile fun;

  @override
  State<SectionPickImagePictureID> createState() =>
      _SectionPickImagePictureIDState();
}

class _SectionPickImagePictureIDState extends State<SectionPickImagePictureID> {
  final ImagePicker imagePicker = ImagePicker();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: rem(1)),
          child: image == null
              ? null
              : Text(
                  "Image ID : ",
                  style: TextStyle(
                    fontSize: rem(1.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        InkWell(
          onTap: () async {
            XFile? imageFromSource;
            await showAlertDialog(context, imagePicker, (ch) async {
              if (ch == 0) {
                imageFromSource = await pickImageFromGallery(imagePicker);
              } else {
                imageFromSource = await pickImageFromCamera(imagePicker);
              }
            });
            printGreen("start");
            if (imageFromSource != null) {
              setState(() {
                image = File(imageFromSource!.path);
              });
              printGrey(image?.path ?? "false");
              widget.fun(image);
            }
          },
          child: AspectRatio(
            aspectRatio: 1.5,
            child: DottedBorder(
              
              options: RoundedRectDottedBorderOptions(
                color: context.appTheme.primarye,
                radius: Radius.circular(rem(1.4)),
                dashPattern: [10, 5],
              ),
              child: image == null
                  ? CaseNotUploadImage()
                  : CaseUploadImage(path: image!),
            ),
          ),
        ),
      ],
    );
  }
}
