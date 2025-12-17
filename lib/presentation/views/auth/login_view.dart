import 'package:booking/data/sections/auth/login_view/section_login.dart';
import 'package:booking/data/sections/auth/login_view/section_logo.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
