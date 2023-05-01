import 'package:flutter/material.dart';
import 'package:pokedex/components/letterPokemon.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double fontsize = size.width > size.height ? size.height : size.width;
    return AppBar(
        toolbarHeight: size.height * 0.13,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: LetterPokemon(text: title, size: fontsize * 0.002));
  }
}
