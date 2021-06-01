import 'dart:core';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../core/models/timetable_model.dart';
import '../../core/provider/power_off_provider.dart';
import 'widgets/date_group_separator_widget.dart';
import 'widgets/list_card_widget.dart';

class ListScreen extends StatelessWidget {
  static const String id = 'list_screen';

  @override
  Widget build(BuildContext context) {
    final powerOffProvider = Provider.of<PowerOffProvider>(
      context,
      listen: false,
    );

    return GroupedListView<TimetableModel, DateTime>(
      elements: powerOffProvider.timetableItems,
      groupBy: (items) => items.timestamp,
      groupSeparatorBuilder: (date) => DateGroupSeparatorWidget(
        date: date,
      ),
      order: GroupedListOrder.ASC,
      useStickyGroupSeparators: true,
      itemBuilder: (_, item) {
        if (item.locations != null) {
          final items = item.locations!
              .map(
                (e) => FrameCardWidget(
                  city: e.houseDetails.city!,
                  street: e.houseDetails.street!,
                  buildingNumber: e.houseDetails.buildingNumber,
                  timeFrames: e.frames,
                ),
              )
              .toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
