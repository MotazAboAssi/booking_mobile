import 'dart:developer';
import 'dart:io';

import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_cubit.dart';
import 'package:booking/presentation/cubit/navigate_from_login/navigate_from_login_states.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ToggleColorCubit()..init()),
        BlocProvider(create: (context) => NavigateFromLoginCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

typedef StringFunVoid = String Function();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<NavigateFromLoginCubit>(context);
    cubit.routeFromLogin(context, navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    log(ThemeMode.values.toString());
    return BlocBuilder<ToggleColorCubit, ToggleColorStates>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state is ToggleColorSuccessful
              ? state.mode
              : ThemeMode.system,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Observ()],
          routes: appRoutes,
          // initialRoute: waitingView,
          home: Scaffold(
            body: FutureBuilder(
              future: HttpRequest().displayAvailableDateForParticularApartment(
                3,
              ),
              builder: (context, snapshot) {
                return Text('data');
              },
            ),
          ),
        );
      },
    );
  }
}
