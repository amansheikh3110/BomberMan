import 'package:flutter/material.dart';

class pixels extends StatelessWidget {
  final innerColor;
  final child;
  final outerColor;
  const pixels({super.key, this.outerColor, this.child, this.innerColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.all(5),
          color: outerColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: innerColor,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
