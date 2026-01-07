import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    final double radius = 4;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: rem(2),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: rem(radius),
                backgroundColor: context.appTheme.fourthly,
                child: Icon(
                  Icons.apartment,
                  color: context.appTheme.thirdly,
                  size: rem(radius),
                ),
              ),
              SizedBox(
                width: rem(2),
                height: rem(2),
                child: CircularProgressIndicator(
                  color: context.appTheme.primarye,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
