import 'package:vroom_core/utils/constants.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double? width;
  final double? radius;
  const CustomButton({
    Key? key,
    required this.text,
    this.radius,
    required this.onPressed,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
        onPressed: onPressed,
      color: ashesiRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 16)
      ),
      child: Text(text,
        style: Theme.of(context).textTheme.bodyText1!
            .copyWith(
            color: Colors.white
        ),
      ),
    );
  }
}
