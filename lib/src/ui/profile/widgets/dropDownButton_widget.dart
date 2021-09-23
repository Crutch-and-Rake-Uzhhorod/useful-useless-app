import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      itemHeight: 100,
      onChanged: onChanged,
      hint: hintText != null ? Text(hintText!) : null,
      items: items
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
    );
  }
}
