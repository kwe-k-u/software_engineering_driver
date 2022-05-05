import 'package:vroom_core/utils/constants.dart';
import 'package:flutter/material.dart';


class CurvedBackground extends StatelessWidget {
  final double? marginHeight;
  final Widget child;
  const CurvedBackground({
    Key? key,
    required this.child,
    this.marginHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              color: ashesiRedLight,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40)
              ),
            ),
              margin: EdgeInsets.only(top:   MediaQuery.of(context).size.height * (marginHeight ?? 0.15)),
              padding: const EdgeInsets.all(16),
              child: Center(child: child)
          )
      ),
    );
  }
}
