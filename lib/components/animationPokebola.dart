import 'package:flutter/material.dart';
import 'package:pokedex/components/letterPokemon.dart';

import '../functions/strings.dart';

class AnimationPokebola extends StatefulWidget {
  final String legend;
  final Color? color;
  const AnimationPokebola({super.key, required this.legend, this.color});

  @override
  State<AnimationPokebola> createState() => _AnimationPokebolaState();
}

class _AnimationPokebolaState extends State<AnimationPokebola>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: widget.color == null
            ? Theme.of(context).colorScheme.background
            : widget.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _animation,
              child: Center(
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(GlobalStrings().pathImageSplashScreen),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: LetterPokemon(text: widget.legend, size: size.width > size.height ? size.height * 0.003 : size.width * 0.003),
            )
          ],
        ),
      ),
    );
  }
}
