
import 'package:booking/helper/methods/rem.dart';
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
            "Upload ID Picture",
            style: TextStyle(fontSize: rem(1.5), fontWeight: FontWeight.bold),
          ),
          Text("PNG, GPG, up to 10MB", style: TextStyle(fontSize: rem(0.8))),
        ],
      ),
    );
  }
}
