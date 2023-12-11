import 'package:flutter/material.dart';

class NoGlowingScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? scrollController;
  const NoGlowingScrollView(
      {Key? key, required this.child, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
