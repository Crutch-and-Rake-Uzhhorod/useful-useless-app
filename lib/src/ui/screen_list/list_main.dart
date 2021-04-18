import 'dart:core';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'date_group_separator.dart';
import 'location_model.dart';



class ListScreen extends StatelessWidget {
  static const String id = 'list_screen';



  final List<LocationModel> fields = [
    LocationModel('Ужгород', 'вул.Шумна', '18:00', '19:00', '18:00', '19:00',
        (DateTime.now())),
    LocationModel('Ужгород', 'вул.Капушанська', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 7, 7)),
    LocationModel('Ужгород', 'вул.Загорська', '18:00', '21:00', '18:00', '19:00',
        DateTime(2021, 7, 7)),
    LocationModel('Ужгород', 'вул.Петефі', '18:00', '22:00', '18:00', '19:00',
        DateTime(2021, 9, 7)),
    LocationModel('Ужгород', 'вул.Шумна', '15:00', '16:45', '18:00', '19:00',
        DateTime(2021, 9, 7)),
    LocationModel('Ужгород', 'вул.Петефі', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 10, 7)),
    LocationModel('Ужгород', 'вул.Швабська', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 11, 7)),
    LocationModel('Ужгород', 'вул.Легоцького', '18:00', '20:00', '18:00', '19:00',
        DateTime(2021, 8, 7)),
    LocationModel('Ужгород', 'вул.Шумна', '15:00', '16:30', '18:00', '19:00',
        DateTime(2021, 6, 7)),
    LocationModel('Ужгород', 'вул.Капушанська', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 6, 8)),
    LocationModel('Ужгород', 'вул.Гагаріна', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 6, 8)),
    LocationModel('Ужгород', 'вул.Петефі', '13:00', '19:00', '18:00', '19:00',
        DateTime(2021, 3, 9)),
    LocationModel('Ужгород', 'вул.Швабська', '18:00', '19:00', '18:00', '19:00',
        DateTime(2021, 2, 9)),
    LocationModel('Ужгород', 'вул.Загорська', '10:00', '19:00', '18:00', '19:00',
        DateTime(2021, 5, 12)),
  ];


  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 3, //
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: GroupedListView<dynamic, DateTime>(
            elements: fields,
            groupBy: (fields) {
              return fields.date;
            },
            groupSeparatorBuilder: (DateTime date) => DateGroupSeparator(
              date: date,
            ),
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            itemBuilder: (context, dynamic fields) => Card(
              child: Container(
                decoration: myBoxDecoration(),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  '${fields.city}, ${fields.street}',
                                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              'Відключення: з ${fields.begin1}  до ${fields.till1} ',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text('Відключення: з ${fields.begin2}  до ${fields.till2} ',
                                style: TextStyle(fontSize: 15.0)),
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



