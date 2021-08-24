import 'dart:core';

import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

// import '../../../core/models/timetable_model.dart';
import '../../../core/provider/power_off_provider.dart';
// import 'date_group_separator_web_widget.dart';
// import 'list_card_web_widget.dart';

class DateListWebWidget extends StatelessWidget {
  static const String id = 'list_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<PowerOffProvider>(
      builder: (_, powerOffProvider, __) {
        // TODO: reimplement with StickySlivers
        return Container();
        // return GroupedListView<TimetableModel, DateTime>(
        //   elements: powerOffProvider.timetableItems,
        //   groupBy: (items) => items.timestamp,
        //   padding: EdgeInsets.zero,
        //   groupSeparatorBuilder: (date) => DateGroupSeparatorWebWidget(
        //     date: date,
        //   ),
        //   order: GroupedListOrder.ASC,
        //   stickyHeaderBackgroundColor: const Color(0xff2F4047),
        //   useStickyGroupSeparators: true,
        //   itemBuilder: (_, item) {
        //     if (item.locations != null) {
        //       final items = item.locations!
        //           .map(
        //             (e) => FrameCardWebWidget(
        //               city: e.houseDetails.city!,
        //               street: e.houseDetails.street!,
        //               buildingNumber: e.houseDetails.buildingNumber,
        //               timeFrames: e.frames,
        //             ),
        //           )
        //           .toList();
        //
        //       return Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: items,
        //       );
        //     } else {
        //       return const SizedBox();
        //     }
        //   },
        // );
      },
    );
  }
}
