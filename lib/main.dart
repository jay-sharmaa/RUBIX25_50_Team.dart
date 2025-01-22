import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rubix_time_machine/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int themeNumber = prefs.getInt('theme') ?? 1;
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(ProviderScope(child: MyApp(themeNumber: themeNumber)));
}

final themeModeProvider = StateProvider<ThemeData>((ref) => Themes.greenDarkTheme);

class MyApp extends ConsumerStatefulWidget {
  final int themeNumber;
  const MyApp({required this.themeNumber, super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  int selected_index = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTheme();
    });
  }

  void _initializeTheme() {
    if (widget.themeNumber == 1) {
      ref.read(themeModeProvider.notifier).state = Themes.greenDarkTheme;
    } else if (widget.themeNumber == 2) {
      ref.read(themeModeProvider.notifier).state = Themes.blueDarkTheme;
    } else if (widget.themeNumber == 3) {
      ref.read(themeModeProvider.notifier).state = Themes.redDarkTheme;
    } else if (widget.themeNumber == 4) {
      ref.read(themeModeProvider.notifier).state = Themes.greenLightTheme;
    } else if (widget.themeNumber == 5) {
      ref.read(themeModeProvider.notifier).state = Themes.blueLightTheme;
    } else if (widget.themeNumber == 6) {
      ref.read(themeModeProvider.notifier).state = Themes.redLightTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      theme: themeMode,
      home: Scaffold(
        body: Home(widget.themeNumber),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          onTap: (value){
            setState(() {
              selected_index = value;
            });
          },
          currentIndex: selected_index,
            items: const [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                  label: "Search",
                  icon: Icon(Icons.search)
              ),
              BottomNavigationBarItem(
                  label: "Profile",
                  icon: Icon(Icons.person)
              ),
            ]
        ),
      ),
    );
  }
}
