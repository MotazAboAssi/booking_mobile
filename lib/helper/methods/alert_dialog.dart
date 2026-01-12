import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef IntCallBacFun = Future<void> Function(int);

Future<void> showAlertDialog(
  BuildContext context,
  ImagePicker picker,
  IntCallBacFun fun,
) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: rem(0.5),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(rem(1)),
                    ),
                  ),
                  child: Text(
                    '🖼️ ${AuthKeys.pickGallery.tr()}',
                    style: TextStyle(fontSize: rem(1.5)),
                  ),
                  onPressed: () async {
                    await fun(0);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    '📷 ${AuthKeys.pickCamera.tr()}',
                    style: TextStyle(fontSize: rem(1.5)),
                  ),
                  onPressed: () async {
                    await fun(1);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
