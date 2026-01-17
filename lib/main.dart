import 'dart:developer';
import 'dart:io';
import 'package:booking/helper/constant/app_theme.dart';
import 'package:booking/presentation/cubit/get_all_notifications/get_all_notifications_cubit.dart';
import 'package:booking/presentation/cubit/locale/locale_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_cubit.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking/helper/constant/routes.dart';
import 'package:booking/helper/test/navigation_observe.dart';

typedef VoidCallBackFile = void Function(File?);
typedef FileCallBackvoid = File? Function();
typedef BoolFunString = bool Function(String);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ToggleColorCubit()..init()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => GetAllNotificationsCubit()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/resource',

        child: const MyApp(),
      ),
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
  Widget build(BuildContext context) {
    log(ThemeMode.values.toString());
    return BlocBuilder<ToggleColorCubit, ToggleColorStates>(
        builder: (context, state) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          // local
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // color
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state is ToggleColorSuccessful
              ? state.mode
              : ThemeMode.system,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [Observ()],
          routes: appRoutes,
          initialRoute: waitingView,
        );
      },
    );
  }
}
