import 'package:booking/data/models/rate_your_stay_view/model_rating_bar.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class ModelFeatureRate extends StatelessWidget {
  final String feature;
  final void Function(double) action;

  const ModelFeatureRate({super.key, required this.feature, required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(feature, style: TextStyle(fontSize: rem(1))),

          trailing: ModelRatingBar(itemSize: rem(1.5), action: action,),
        ),
      ],
    );
  }
}
