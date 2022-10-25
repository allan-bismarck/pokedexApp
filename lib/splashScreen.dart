import 'package:flutter/material.dart';
import 'package:pokedex/animationPokebola.dart';
import 'dart:async';

import 'package:pokedex/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage()),
      );
});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: AnimationPokebola(legend: 'Inicializando Pokedex'),
      ),
    );
  }
}