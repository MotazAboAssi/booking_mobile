import 'package:booking/helper/keys_localization/auth_key.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CaseNotUploadImage extends StatelessWidget {
  const CaseNotUploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: rem(2),
            child: Icon(Icons.upload_file_rounded, size: rem(2)),
          ),
          Text(
            AuthKeys.idUploadTitle.tr(),
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
          Text(
            AuthKeys.idUploadRequirement.tr(),
            style: TextStyle(fontSize: rem(0.8)),
          ),
        ],
      ),
    );
  }
}
