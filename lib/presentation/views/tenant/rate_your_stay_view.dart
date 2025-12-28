import 'package:booking/presentation/widgets/rate_your_stay_view/app_bar_rate_your_stay_view.dart';
import 'package:booking/presentation/widgets/rate_your_stay_view/body_rate_your_stay.dart';
import 'package:flutter/material.dart';

class RateYourStayView extends StatelessWidget {
  const RateYourStayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarRateYourStayView(), body: BodyRateYourStay());
  }

  
}