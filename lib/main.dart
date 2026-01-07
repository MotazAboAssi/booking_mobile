import 'dart:developer';
import 'dart:io';

import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

void main() async {
  runApp(
    BlocProvider(create: (context) => ToggleColorCubit(), child: const MyApp()),
  );
}

typedef StringFunVoid = String Function();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<ToggleColorCubit>(context);
    cubit.fromScratch();
  }

  @override
  Widget build(BuildContext context) {
    log(ThemeMode.values.toString());
    return BlocBuilder<ToggleColorCubit, ToggleColorStates>(
      builder: (context, state) {
        printWhite('${state.mode?.name}');
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.mode ?? ThemeMode.system,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Observ()],
          routes: appRoutes,
          initialRoute: loginView,
        );
      },
    );
  }
}
