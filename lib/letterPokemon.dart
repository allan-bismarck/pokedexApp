import 'package:flutter/material.dart';

class LetterPokemon extends StatelessWidget {
  final String text;
  final double? size;
  const LetterPokemon({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text, 
          style: Theme.of(context).textTheme.headline4,
          textScaleFactor: size == null? 1 : size,
        ),
        Text(
          text, 
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: size == null? 1 : size,
        )
      ],
    );
  }
}
