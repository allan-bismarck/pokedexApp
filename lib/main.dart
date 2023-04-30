import 'package:flutter/material.dart';
import 'package:pokedex/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'mobx/appStore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();

    return Provider(
      create: (_) => AppStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cod4Dex',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Color.fromARGB(255, 242, 5, 48),
            primaryContainer: Color.fromARGB(255, 242, 15, 15),
            secondary: Color.fromARGB(255, 4, 119, 191),
            tertiary: Color.fromARGB(255, 242, 183, 5),
            background: Color.fromARGB(255, 4, 196, 217),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
