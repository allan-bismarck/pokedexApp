import 'package:flutter/material.dart';
import 'package:pokedex/letterPokemon.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final double? fontsize;
  final bool? arrowBack;
  const MyAppBar(
      {super.key, required this.title, this.fontsize, this.arrowBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: arrowBack == null ? Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                InkWell(
                  onTap: Navigator.of(context).pop,
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  LetterPokemon(
                    text: title,
                    size: fontsize,
                  ),
                ],
              ),
            ),
          ],
        ) : Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  LetterPokemon(
                    text: title,
                    size: fontsize,
                  ),
                ],
              ),
            )
          );
  }
}
