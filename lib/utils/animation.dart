import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension Anim on Widget {
  Widget listTileAnim1([int index = 1]) {
    return animate()
        .moveX(
          begin: 10,
          end: 0,
          curve: Curves.ease,
          delay: Duration(milliseconds: index * 200),
          duration: Durations.long4,
        )
        .fadeIn(
          begin: 0.0,
          curve: Curves.ease,
          delay: Duration(milliseconds: index * 200),
          duration: Durations.long4,
        );
  }
}
