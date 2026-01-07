import 'package:booking/helper/methods/determine_mode_by_index.dart';
import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/toggle_color/toggle_color_states.dart';
import 'package:booking/services/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleColorCubit extends Cubit<ToggleColorStates> {
  ToggleColorCubit() : super(ToggleColorLoading());

  Future<void> init() async {
    try {
      final storage = AuthStorage();

      if (await storage.isKeyExistence('mode')) {
        final String? mode = await storage.readData('mode');
        printWhite('$mode');

        // if (mode != null && mode.isNotEmpty) {
        await AuthStorage().writeData('mode', '$mode');
        emit(ToggleColorSuccessful(mode: appMode('$mode')));
        return;
        // }
      }

      // fallback ONLY if no saved value exists
      await AuthStorage().writeData('mode', 'system');
      emit(ToggleColorSuccessful(mode: appMode('system')));
    } catch (e) {
      emit(ToggleColorFailed(mode: appMode('system'), message: e.toString()));
    }
  }

  Future<void> toggle(BuildContext context) async {
    try {
      emit(ToggleColorLoading());
      printWhite(
        'await AuthStorage().isKeyExistence : ${await AuthStorage().isKeyExistence('mode')}',
      );
      if (!await AuthStorage().isKeyExistence('mode')) {
        printGreen('system');
        await AuthStorage().writeData('mode', 'system');
        emit(ToggleColorSuccessful(mode: appMode('system')));
        return;
      }
      // final String? colorMode = await AuthStorage().readData('mode');
      final String newMode = Theme.of(context).brightness == Brightness.light
          ? 'dark'
          : 'light';
      printRed(newMode);
      await AuthStorage().writeData('mode', newMode);

      emit(ToggleColorSuccessful(mode: appMode(newMode)));
    } catch (e) {
      emit(ToggleColorFailed(mode: appMode(''), message: e.toString()));
    }
    return;
  }

  Future<void> fromScratch() async {
    if (await AuthStorage().isKeyExistence('mode')) {
      await AuthStorage()
          .readData('mode')
          .then((String? mode) {
            if (mode == null || mode.isEmpty) {
              emit(ToggleColorInitial(mode: appMode('system')));
            } else {
              emit(ToggleColorInitial(mode: appMode(mode)));
            }
          })
          .catchError((Object e) {
            emit(ToggleColorFailed(mode: appMode(''), message: e.toString()));
          });
    }
  }
}
