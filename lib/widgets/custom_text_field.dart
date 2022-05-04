import "package:flutter/material.dart";


class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? label;
  final IconData? icon;
  final TextEditingController controller;
  final bool obscureText;
  bool visibility;
  final String? Function(String?)? validator;

  CustomTextField({
    Key? key,
    required this.controller,
    this.icon,
    this.validator,
    this.label,
    this.visibility = true,
    this.obscureText = false,
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
      child: Visibility(
        visible: widget.visibility,
        child: TextFormField(
          validator: widget.validator,
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration:  InputDecoration(
            label: widget.label != null ? Text(widget.label!) : null,
              prefixIcon: Icon(widget.icon),
              hintText: widget.hintText
          ),
        ),
      ),
    );
  }
}
