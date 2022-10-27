import 'package:flutter/material.dart';

class LetterPokemon extends StatelessWidget {
  final String text;
  final double? size;
  const LetterPokemon({super.key, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Text(
            text,
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontFamily: 'Pokemon-Solid',
              fontSize: 25,
              letterSpacing: size == null ? 8.0 : size! * 5,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = size == null ? 8.0 : size! * 8
                ..color = Color.fromARGB(255, 3, 101, 161),
            ),
            textScaleFactor: size == null? 1 : size,
          ),
          Text(
            text, 
            textAlign: TextAlign.center, 
            style: TextStyle(
              color: Color.fromARGB(255, 242, 183, 5),
              fontSize: 25,
              letterSpacing: size == null ? 8.0 : size! * 5,
              fontFamily: 'Pokemon-Solid',
            ),
            textScaleFactor: size == null? 1 : size,
          )
        ],
      ),
    );
  }
}