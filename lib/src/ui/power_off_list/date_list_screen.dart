import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../core/provider/power_off_provider.dart';
import 'widgets/date_separator_widget.dart';
import 'widgets/list_card_widget.dart';
import 'widgets/size_measurment_widget.dart';

// ignore: must_be_immutable
class PowerOffListScreen extends StatelessWidget {
  static const String id = 'list_screen';

  //TODO: recreate sticky header with the package "sticky_headers"

  @override
  Widget build(BuildContext context) {
    return Consumer<PowerOffProvider>(
      builder: (_, powerOffProvider, __) {
        powerOffProvider.currentDate();
        powerOffProvider.initController();
        final height = MediaQuery.of(context).size.height;
        return CustomScrollView(
          primary: false,
          controller: powerOffProvider.headersListScrollController,
          slivers: [
            SliverPadding(padding: const EdgeInsets.only(top: 16)),
            ...powerOffProvider.timetableItems.map(
              (e) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      StickyHeader(
                        header: MeasureSize(
                          onChange: (Size i) {
                            powerOffProvider.getParentSize(i);
                            powerOffProvider.animateToCurrentDate();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                            child: DateSeparatorWidget(
                              date: e.timestamp,
                            ),
                          ),
                        ),
                        content:
                            // SizedBox(
                            //   height: height,
                            //   child: NotificationListener(
                            //     onNotification:
                            //         powerOffProvider.handleScrollNotification,
                            //     child: ListWheelScrollView .useDelegate(
                            //       perspective: 0.00002,
                            //       squeeze: 1.2,
                            //       controller: powerOffProvider
                            //           .myfixedExtentScrollController,
                            //       itemExtent: 162,
                            //       onSelectedItemChanged:
                            //           powerOffProvider.onSelectedDateChanged,
                            //       childDelegate: ListWheelChildBuilderDelegate(
                            e.locations.isNotEmpty
                                ? SizedBox(
                                    height:
                                        powerOffProvider.widgetChildSize == 0
                                            ? 0
                                            : height,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        bottom: 90,
                                      ),
                                      primary: true,
                                      itemCount: e.locations.length,
                                      itemBuilder: (context, index) {
                                        final details =
                                            e.locations[index].houseDetails;
                                        final geoId = details.geoId;
                                        return MeasureSize(
                                          onChange: (Size i) {
                                            powerOffProvider.getChildSize(i);
                                          },
                                          child: FrameCardWidget(
                                            city: details.city!.toUpperCase(),
                                            street: details.street!,
                                            buildingNumber:
                                                details.buildingNumber,
                                            timeFrames:
                                                e.locations[index].frames,
                                            isFollowed: powerOffProvider
                                                .isFollowing(geoId),
                                            onFollowTapped: (_) =>
                                                powerOffProvider.follow(geoId),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(),
                      ),
                    ],
                  ),
                );
              },

              //     SliverStickyHeader(
              //   header: DateSeparatorWidget(
              //     date: e.timestamp,
              //   ),
              //   sliver: SliverList(
              //     delegate: SliverChildBuilderDelegate(
              //       (_, i) {
              //         final details = e.locations[i].houseDetails;
              //
              //         final geoId = details.geoId;
              //         return FrameCardWidget(
              //           city: details.city!.capitalize(),
              //           street: details.street!,
              //           buildingNumber: details.buildingNumber,
              //           timeFrames: e.locations[i].frames,
              //           isFollowed: powerOffProvider.isFollowing(geoId),
              //           onFollowTapped: (_) =>
              //               powerOffProvider.follow(geoId),
              //         );
              //       },
              //       childCount: e.locations.length,
              //     ),
              //   ),
              // ),
            ).toList(),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 90.0),
            ),
          ],
        );
      },
    );
  }
}
