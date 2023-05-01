import 'package:flutter/material.dart';

class MyTheme {

  final theme = ThemeData();

  getTheme() {
    return  theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                primary: const Color.fromARGB(255, 242, 5, 48),
                primaryContainer: const Color.fromARGB(255, 242, 15, 15),
                secondary: const Color.fromARGB(255, 4, 119, 191),
                tertiary: const Color.fromARGB(255, 242, 183, 5),
                background: const Color.fromARGB(255, 4, 196, 217),
              ) 
    );
  }

}