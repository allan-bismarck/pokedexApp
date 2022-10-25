import 'package:flutter/material.dart';

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
    return Center(
      child: Container(
        color: widget.color == null ? Theme.of(context).colorScheme.background : widget.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _animation,
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('lib/assets/images/pokebola.png'),
                ),
              ),
            ),
            Stack(
              children: [
                Text(widget.legend,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
                Text(widget.legend,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
