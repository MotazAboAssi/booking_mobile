import 'package:booking/data/models/rate_your_stay_view/model_rating_bar.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SectionOverallExperience extends StatelessWidget {
  const SectionOverallExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Overall Experience",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: rem(1.5)),
        ),

        RatingBar.builder(
          initialRating: 5,
          itemCount: 5,
          glow: false,
          itemSize: rem(3),
          itemPadding: EdgeInsetsGeometry.all(rem(0.5)),
          
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(Icons.sentiment_neutral, color: Colors.amber);
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
            }
            return Container();
          },
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }
}
