import 'package:flutter/material.dart';
import 'package:pokedex/components/myTheme.dart';
import 'package:pokedex/screens/splashScreen.dart';
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

    return Provider(
      create: (_) => AppStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: MyTheme().getTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
