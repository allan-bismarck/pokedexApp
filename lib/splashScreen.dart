import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pokedex/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: SizeTransition(
            sizeFactor: _animation,
            axis: Axis.horizontal,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: FlutterLogo(size: 250),
                    ),
                    Text(
                      'Inicializando a Pokedex',
                      textAlign: TextAlign.center,
                      textScaleFactor: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}