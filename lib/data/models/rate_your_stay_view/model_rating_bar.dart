import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ModelRatingBar extends StatelessWidget {
  final double itemSize;
  final void Function(double)? action;
  final double? initialRating;
  final bool? ignoreGestures;
  const ModelRatingBar({
    super.key,
    required this.itemSize,
    this.action,
    this.initialRating,
    this.ignoreGestures,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      direction: Axis.horizontal,
      itemCount: 5,
      ignoreGestures: ignoreGestures ?? false,
      initialRating: initialRating ?? 0,
      glow: false,
      itemSize: itemSize,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star_rounded, color: Colors.amber),
        half: Icon(Icons.star_border_rounded, color: Colors.amber),
        empty: Icon(Icons.star_border_rounded, color: Colors.amber),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: action ?? (double d) {},
    );
  }
}
