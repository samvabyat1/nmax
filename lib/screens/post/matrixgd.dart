import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

class MatrixGD extends StatelessWidget {
  final Widget child;
  const MatrixGD({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          notifier.value = m;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, buildChild) {
            return Transform(
              transform: notifier.value,
              child: Container(
                  padding: EdgeInsets.all(32),
                  alignment: Alignment(0, 0),
                  child: child),
            );
          },
        ),
      ),
    );
  }
}
