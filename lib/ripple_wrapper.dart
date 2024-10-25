import 'package:flutter/material.dart';

class RippleWrapper extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  const RippleWrapper({super.key, required this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {},
        child: child,
      ),
    );
  }
}
