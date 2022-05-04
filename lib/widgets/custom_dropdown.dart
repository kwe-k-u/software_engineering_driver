import "package:flutter/material.dart";


class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final void Function(dynamic e) onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField(
        value: widget.value,
      items: widget.items,
      onChanged: widget.onChanged,
    ),
    );
  }
}
