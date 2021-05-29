import 'dart:core';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../core/models/frame_model.dart';
import '../../../core/models/house_details_model.dart';
import '../../../core/models/location_coordinates.dart';
import '../../../core/models/time_frame_model.dart';
import '../../../core/models/timetable_model.dart';
import 'date_group_separator_web_widget.dart';
import 'list_card_web_widget.dart';

class DateListWebWidget extends StatelessWidget {
  static const String id = 'list_screen';

  final List<TimetableModel> dates = [
    TimetableModel(
      timestamp: DateTime(2021, 7, 7),
      locations: [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 18),
              start: DateTime(2021, 7, 7, 17),
            ),
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 21),
              start: DateTime(2021, 7, 7, 20),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Капушанська',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 7, 7, 17),
              start: DateTime(2021, 7, 7, 16),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Загорська',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
      ],
    ),
    TimetableModel(
      timestamp: DateTime(2021, 9, 7),
      locations: [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 9, 7, 16, 45),
              start: DateTime(2021, 9, 7, 15),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Шумна',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 9, 7, 14),
              start: DateTime(2021, 9, 7, 11),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Петефі',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
      ],
    ),
    TimetableModel(
      timestamp: DateTime(2021, 10, 7),
      locations: [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 10, 7, 18),
              start: DateTime(2021, 10, 7, 16),
            ),
            TimeFrameModel(
              end: DateTime(2021, 10, 7, 19, 30),
              start: DateTime(2021, 10, 7, 15),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Петефі',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
      ],
    ),
    TimetableModel(
      timestamp: DateTime(2021, 11, 7),
      locations: [
        FrameModel(
          frames: [
            TimeFrameModel(
              end: DateTime(2021, 11, 7, 20),
              start: DateTime(2021, 11, 7, 19),
            ),
            TimeFrameModel(
              end: DateTime(2021, 11, 7, 20),
              start: DateTime(2021, 11, 7, 19, 30),
            ),
          ],
          houseDetails: HouseDetailsModel(
            city: 'Ужгород',
            street: 'вул.Швабска',
            geoId: '',
            location: LocationCoordinates(lat: 46.0, lng: 42.0),
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GroupedListView<TimetableModel, DateTime>(
      elements: dates,
      groupBy: (dates) => dates.timestamp,
      groupSeparatorBuilder: (date) => DateGroupSeparatorWebWidget(
        date: date,
      ),
      order: GroupedListOrder.ASC,
      useStickyGroupSeparators: true,
      itemBuilder: (_, date) {
        final items = date.locations
            .map(
              (e) => FrameCardWebWidget(
                city: e.houseDetails.city!,
                timeFrames: e.frames,
                street: e.houseDetails.street!,
              ),
            )
            .toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        );
      },
    );
  }
}
