import 'package:flutter/material.dart';
import 'package:pokedex/splashScreen.dart';
import 'package:provider/provider.dart';
import 'homePage.dart';
import 'mobx/appStore.dart';

void main() {
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
