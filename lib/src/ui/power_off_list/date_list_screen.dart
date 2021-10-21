import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

import '../../core/provider/power_off_provider.dart';
import '../../core/repository/string_repository.dart';
import 'widgets/date_separator_widget.dart';
import 'widgets/list_card_widget.dart';

// ignore: must_be_immutable
class PowerOffListScreen extends StatelessWidget {
  static const String id = 'list_screen';
  StickyHeaderController stickyHeaderController = StickyHeaderController();

  void a() {
    stickyHeaderController.stickyHeaderScrollOffset = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PowerOffProvider>(
      builder: (_, powerOffProvider, __) {
        return CustomScrollView(
          slivers: [
            ...powerOffProvider.timetableItems
                .map(
                  (e) => SliverStickyHeader(
                    controller: stickyHeaderController,
                    header: DateSeparatorWidget(
                      date: e.timestamp,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) {
                          final details = e.locations[i].houseDetails;

                          final geoId = details.geoId;
                          return FrameCardWidget(
                            city: details.city!.capitalize(),
                            street: details.street!,
                            buildingNumber: details.buildingNumber,
                            timeFrames: e.locations[i].frames,
                            isFollowed: powerOffProvider.isFollowing(geoId),
                            onFollowTapped: (_) =>
                                powerOffProvider.follow(geoId),
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
