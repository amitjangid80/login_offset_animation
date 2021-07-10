// Created By Amit Jangid 10/07/21

import 'package:flutter/material.dart';

class OffsetAnimation extends AnimatedWidget {
  final double end;
  final Widget widget;
  final AnimationController animationController;

  OffsetAnimation({@required this.end, @required this.widget, @required this.animationController})
      : super(
          listenable:
              Tween(begin: 0.0, end: end).chain(CurveTween(curve: Curves.elasticIn)).animate(animationController)
                ..addStatusListener(
                  (status) {
                    if (status == AnimationStatus.completed) {
                      animationController.reverse();
                    }
                  },
                ),
        );

  @override
  Widget build(BuildContext context) {
    final Animation _animation = listenable as Animation<double>;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          child: widget,
          padding: EdgeInsets.only(left: end + _animation.value, right: end - _animation.value),
        );
      },
    );
  }
}
