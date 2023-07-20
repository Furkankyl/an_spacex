import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomAnimate extends StatefulWidget {
  final List<Effect<dynamic>> effects;
  final Widget child;

  const CustomAnimate({Key? key, required this.effects, required this.child})
      : super(key: key);

  @override
  State<CustomAnimate> createState() => _CustomAnimateState();
}

///Animasyonun sürekli tekrarlanmaması için [AutomaticKeepAliveClientMixin] kullanılmalı
/// [AutomaticKeepAliveClientMixin] Kullanmak içinde stateful widget olmalı
class _CustomAnimateState extends State<CustomAnimate> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Animate(
      effects: widget.effects,
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
