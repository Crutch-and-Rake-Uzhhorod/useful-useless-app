import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/profile_provider.dart';

class AutocompleteWidget extends StatelessWidget {
  AutocompleteWidget({
    this.hint,
    this.city = false,
    this.region = false,
  });

  final String? hint;
  final bool region;
  final bool city;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (city) {
          final cityOptions = profileProvider.listOfChosenCities;
          return cityOptions.where(
            (element) {
              return element.toLowerCase().startsWith(
                    textEditingValue.text.toLowerCase(),
                  );
            },
          );
        }

        if (region) {
          final regionsOptions = profileProvider.listOfChosenRegions;
          return regionsOptions.where(
            (element) {
              return element.toLowerCase().startsWith(
                    textEditingValue.text.toLowerCase(),
                  );
            },
          );
        }
        return const Iterable<String>.empty();
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          void Function() function) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: hint,
          ),
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            function();
          },
        );
      },
    );
  }
}
