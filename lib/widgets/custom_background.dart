import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          const RiveAnimation.asset("assets/space_coffee.riv"),
          child
        ],
      ),
    );
  }
}
