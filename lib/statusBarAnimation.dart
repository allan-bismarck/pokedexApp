import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final String? title;
  final color;
  final int? value;
  final size;
  const StatusBar({super.key, this.title, this.color, this.value, this.size});

  @override
  Widget build(BuildContext context) {
    double fontsize = size.width > size.height ? size.height : size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontsize * 0.035,
                    color: Colors.black),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 350
                  ),
                  height: size.height * 0.03,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 350
                  ),
                  height: size.height * 0.03,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(115, 0, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                StatusBarAnimation(
                  widget: Container(
                    constraints: BoxConstraints(
                      maxWidth: size.width * 0.7
                    ),
                    height: size.height * 0.03,
                    width: value! / 0.7,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            style: BorderStyle.solid,
                            width: 1,
                            color: Color.fromARGB(78, 0, 0, 0))),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '${value!}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize * 0.03,
                      color: Colors.black),
                ))
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

class StatusBarAnimation extends StatefulWidget {
  final Widget widget;
  const StatusBarAnimation({super.key, required this.widget});

  @override
  State<StatusBarAnimation> createState() => _StatusBarAnimationState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _StatusBarAnimationState extends State<StatusBarAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
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
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child: widget.widget);
  }
}
