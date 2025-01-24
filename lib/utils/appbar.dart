import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'colors.dart';

const String themeKey = 'theme';

class Appbar extends ConsumerWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return AppBar(
      scrolledUnderElevation: 10,
      title: const Text("HistoryMate"),
      actions: [
        IconButton(
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            if (themeMode == Themes.greenDarkTheme) {
              ref.read(themeModeProvider.notifier).state = Themes.blueDarkTheme;
              await prefs.setInt(themeKey, 2);
              ref.read(themeNumber.notifier).state = 2;
            } else if (themeMode == Themes.blueDarkTheme) {
              ref.read(themeModeProvider.notifier).state = Themes.redDarkTheme;
              await prefs.setInt(themeKey, 3);
              ref.read(themeNumber.notifier).state = 3;
            } else if (themeMode == Themes.redDarkTheme) {
              ref.read(themeModeProvider.notifier).state =
                  Themes.greenLightTheme;
              await prefs.setInt(themeKey, 4);
              ref.read(themeNumber.notifier).state = 4;
            } else if (themeMode == Themes.greenLightTheme) {
              ref.read(themeModeProvider.notifier).state =
                  Themes.blueLightTheme;
              await prefs.setInt(themeKey, 5);
              ref.read(themeNumber.notifier).state = 1;
            } else if (themeMode == Themes.blueLightTheme) {
              ref.read(themeModeProvider.notifier).state = Themes.redLightTheme;
              await prefs.setInt(themeKey, 6);
            } else if (themeMode == Themes.redLightTheme) {
              ref.read(themeModeProvider.notifier).state =
                  Themes.greenDarkTheme;
              await prefs.setInt(themeKey, 1);
            }
          },
          icon: const Icon(Icons.settings),
        )
      ],
    );
  }
}
