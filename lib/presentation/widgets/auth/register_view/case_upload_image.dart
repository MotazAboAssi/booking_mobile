
import 'dart:io';

import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class CaseUploadImage extends StatelessWidget {
  final File path;
  const CaseUploadImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: FileImage(path), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(rem(1.4)),
      ),
    );
  }
}

