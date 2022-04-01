import "package:flutter/material.dart";


class CustomTextField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.icon,
    this.obscureText = true,
    this.hintText
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration:  InputDecoration(
            prefixIcon: Icon(widget.icon),
            hintText: widget.hintText
        ),
      ),
    );
  }
}