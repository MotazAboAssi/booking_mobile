import 'package:booking/data/models/rate_your_stay_view/model_feature_rate.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionFeatureRate extends StatelessWidget {
  const SectionFeatureRate({super.key});

  get rating => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        ModelFeatureRate(
          feature: 'CleanLiness',
          action: (double rating) {
            final pov = BlocProvider.of<RateYourStayCubit>(context).state.pov;
            pov.cleanLess = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'Location',
          action: (double rating) {
            final pov = BlocProvider.of<RateYourStayCubit>(context).state.pov;
            pov.location = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'Communication',
          action: (double rating) {
            final pov = BlocProvider.of<RateYourStayCubit>(context).state.pov;
            pov.communication = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'Value',
          action: (double rating) {
            final pov = BlocProvider.of<RateYourStayCubit>(context).state.pov;
            pov.value = rating.floor();
          },
        ),
      ],
    );
  }
}
