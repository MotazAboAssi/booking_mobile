import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<NavigateFromLoginCubit>(context);
    cubit.routeFromLogin(context, navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    final double radius = 4;
    return Builder(
      builder: (context) {
        return BlocBuilder<NavigateFromLoginCubit, NavigateFromLoginStates>(
          builder: (context, state) {
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
          },
        );
      },
    );
  }
}
