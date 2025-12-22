import 'package:booking/data/sections/auth/login_view/section_login.dart';
import 'package:booking/data/sections/auth/login_view/section_logo.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    final cubit = BlocProvider.of<NavigateFromLoginCubit>(context);
    if (cubit.state.role.isNotEmpty) cubit.routeFromLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
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
  }
}
