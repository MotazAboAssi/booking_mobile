import 'package:booking/data/models/rate_your_stay_view/model_feature_rate.dart';
import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionFeatureRate extends StatelessWidget {
  const SectionFeatureRate({super.key});

  @override
  Widget build(BuildContext context) {
    final pov = context.read<RateYourStayCubit>().state.pov;

    return Column(
      spacing: 5,
      children: [
        ModelFeatureRate(
          feature: 'rate.features.cleanliness'.tr(),
          action: (double rating) {
            pov.cleanLess = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'rate.features.location'.tr(),
          action: (double rating) {
            pov.location = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'rate.features.communication'.tr(),
          action: (double rating) {
            pov.communication = rating.floor();
          },
        ),
        ModelFeatureRate(
          feature: 'rate.features.value'.tr(),
          action: (double rating) {
            pov.value = rating.floor();
          },
        ),
      ],
    );
  }
}
