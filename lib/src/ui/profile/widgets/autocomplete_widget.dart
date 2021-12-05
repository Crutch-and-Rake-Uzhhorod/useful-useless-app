import 'package:flutter/material.dart';

class AutocompleteWidget<T> extends StatelessWidget {
  AutocompleteWidget({
    this.hintText,
    required this.options,
    this.onSubmit,
    this.value = '',
  });

  final String? hintText;
  final List<String> options;
  final ValueChanged<String>? onSubmit;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) => options.where(
        (element) => element.startsWith(
          RegExp(RegExp.escape(textEditingValue.text), caseSensitive: false),
        ),
      ),
      onSelected: onSubmit,
      fieldViewBuilder: (_, textEditingController, focusNode, ___) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: hintText,
          ),
          focusNode: focusNode,
          controller: textEditingController
            ..value = textEditingController.value.copyWith(text: value),
          onFieldSubmitted: onSubmit,
        );
      },
    );
  }
}
