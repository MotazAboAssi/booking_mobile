import 'package:booking/helper/constant/theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class SectionSubmitReviewAndSkip extends StatelessWidget {
  final BoxConstraints parent;
  const SectionSubmitReviewAndSkip({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: fourthly,

        fixedSize: Size(parent.maxHeight * 0.9, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      child: Text(
        "Submit Review",
        style: TextStyle(
          color: thirdly,
          fontWeight: FontWeight.bold,
          fontSize: rem(1),
        ),
      ),
    );
  }
}
