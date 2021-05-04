import 'package:flutter/material.dart';

import '../../../core/models/time_frame_model.dart';
import '../../../core/repository/date_time_repository.dart';

class FrameCardWidget extends StatelessWidget {
  const FrameCardWidget({
    Key? key,
    required this.city,
    required this.street,
    required this.timeFrames,
  }) : super(key: key);

  final String city;
  final String street;
  final List<TimeFrameModel> timeFrames;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final textFrames = timeFrames
        .map(
          (e) => Text(
            'Відключення: з ${DateTimeRepository.dateToHour(e.start)}  до ${DateTimeRepository.dateToHour(e.end)} ',
            style: textTheme.headline6?.copyWith(
              fontSize: 15,
            ),
          ),
        )
        .toList();

    return Card(
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
                        '$city, $street',
                        textAlign: TextAlign.start,
                        style: textTheme.headline6?.copyWith(fontSize: 20),
                      ),
                    ),
                    ...textFrames,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
