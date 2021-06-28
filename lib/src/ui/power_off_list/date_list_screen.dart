import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

import '../../core/provider/power_off_provider.dart';
import 'widgets/date_separator_widget.dart';
import 'widgets/list_card_widget.dart';

class PowerOffListScreen extends StatelessWidget {
  static const String id = 'list_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<PowerOffProvider>(
      builder: (_, powerOffProvider, __) {
        return CustomScrollView(
          slivers: [
            ...powerOffProvider.timetableItems
                .map(
                  (e) => SliverStickyHeader(
                    header: DateSeparatorWidget(
                      date: e.timestamp,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) {
                          return FrameCardWidget(
                            city: e.locations[i].houseDetails.city!,
                            street: e.locations[i].houseDetails.street!,
                            buildingNumber:
                                e.locations[i].houseDetails.buildingNumber,
                            timeFrames: e.locations[i].frames,
                          );
                        },
                        childCount: e.locations.length,
                      ),
                    ),
                  ),
                )
                .toList(),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 90.0),
            ),
          ],
        );
      },
    );
  }
}
