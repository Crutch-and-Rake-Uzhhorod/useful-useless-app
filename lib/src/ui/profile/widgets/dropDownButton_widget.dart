import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/profile_provider.dart';

class DropDownButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return DropdownButton(
      value: profileProvider.areaItem,
      itemHeight: 100,
      onChanged: (String? newValue) {
        if (newValue != null) {
          profileProvider.updateAreaItem(newItem: newValue);
        }
      },
      hint: Text('Місто'),
      items: profileProvider.area.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
