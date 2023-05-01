import 'package:flutter/material.dart';
import 'package:pokedex/components/animationPokebola.dart';
import 'dart:async';

import 'package:pokedex/screens/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 8), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationPokebola(
        legend: 'Inicializando Pokédex',
      ),
    );
  }
}
