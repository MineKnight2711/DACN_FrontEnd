import 'package:flutter/material.dart';

class NoGlowingScrollView extends StatelessWidget {
  final Widget child;

  const NoGlowingScrollView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
