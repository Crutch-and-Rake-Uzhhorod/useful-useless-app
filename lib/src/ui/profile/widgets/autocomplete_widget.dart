import 'package:flutter/material.dart';

class AutocompleteWidget<T> extends StatelessWidget {
  AutocompleteWidget({
    this.hintText,
    required this.options,
  });

  final String? hintText;

  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) => options.where(
        (element) => element.toLowerCase().startsWith(
              textEditingValue.text.toLowerCase(),
            ),
      ),
      onSelected: (String selection) => print('You just selected $selection'),
      fieldViewBuilder: (_, textEditingController, focusNode, ___) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: hintText,
          ),
          focusNode: focusNode,
          controller: textEditingController,
        );
      },
    );
  }
}
