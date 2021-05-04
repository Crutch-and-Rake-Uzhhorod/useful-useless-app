import 'dart:core';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'location_model.dart';
import 'widgets/date_group_separator_widget.dart';

class ListScreen extends StatelessWidget {
  static const String id = 'list_screen';

  final List<LocationModel> fields = [
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Шумна',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime.now()),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Капушанська',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 7, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Загорська',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '21:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 7, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Петефі',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '22:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 9, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Шумна',
        firstTurnOffStarts: '15:00',
        firstTurnOffEnds: '16:45',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 9, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Петефі',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 10, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Швабська',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 11, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Легоцького',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '20:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 8, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Шумна',
        firstTurnOffStarts: '15:00',
        firstTurnOffEnds: '16:30',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 6, 7)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Капушанська',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 6, 8)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Гагаріна',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 6, 8)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Петефі',
        firstTurnOffStarts: '13:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 3, 9)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Швабська',
        firstTurnOffStarts: '18:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 2, 9)),
    LocationModel(
        city: 'Ужгород',
        street: 'вул.Загорська',
        firstTurnOffStarts: '10:00',
        firstTurnOffEnds: '19:00',
        secondTurnOffStarts: '18:00',
        secondTurnOffEnds: '19:00',
        date: DateTime(2021, 5, 12)),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: GroupedListView<LocationModel, DateTime>(
          elements: fields,
          groupBy: (fields) => fields.date!,
          groupSeparatorBuilder: (DateTime date) => DateGroupSeparatorWidget(
            date: date,
          ),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          itemBuilder: (context, LocationModel? fields) => Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3, //
                ),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    child: Icon(
                      Icons.home_rounded,
                      size: 80.00,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${fields?.city}, ${fields?.street}',
                              textAlign: TextAlign.start,
                              style:
                                  textTheme.headline6?.copyWith(fontSize: 20),
                            ),
                          ),
                          Text(
                            'Відключення: з ${fields?.firstTurnOffStarts}  до ${fields?.firstTurnOffEnds} ',
                            style: textTheme.headline6?.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Відключення: з ${fields?.secondTurnOffStarts}  до ${fields?.secondTurnOffEnds} ',
                            style: textTheme.headline6?.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
