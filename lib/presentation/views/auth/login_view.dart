import 'package:booking/data/sections/auth/login_view/section_login.dart';
import 'package:booking/data/sections/auth/login_view/section_logo.dart';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/methods/rem.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<NavigateFromLoginCubit>(context);
    // cubit.routeFromLogin(context);

    return BlocBuilder(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      bloc: NavigateFromLoginCubit(),
      builder: (BuildContext context, state) {
        // log((state is NavigateInitial).toString());
        if (state is NavigateInitial) {
          return Scaffold(
            body: Container(
              color: context.appTheme.fourthly,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                    ),
                    child: SectionLogo(),
                  ),
                  Expanded(child: SectionLogin()),
                ],
              ),
            ),
          );
        } else {
          // if (state is NavigateTo) {
          return Scaffold(
            body: Center(
              child: CircleAvatar(
                backgroundColor: context.appTheme.fourthly,
                radius: rem(5),
                child: Icon(
                  Icons.apartment,
                  size: rem(5),
                  color: context.appTheme.thirdly,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
