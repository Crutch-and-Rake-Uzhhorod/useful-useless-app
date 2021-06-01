import 'package:flutter/material.dart';

import '../../../core/models/time_frame_model.dart';
import '../../../core/repository/date_time_repository.dart';

class FrameCardWebWidget extends StatelessWidget {
  const FrameCardWebWidget({
    Key? key,
    required this.city,
    required this.street,
    required this.timeFrames,
    this.buildingNumber = '',
  }) : super(key: key);

  final String city;
  final String street;
  final String? buildingNumber;
  final List<TimeFrameModel> timeFrames;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final textFrames = timeFrames
        .map(
          (e) => Text(
            'Відключення: з ${DateTimeRepository.dateToHour(e.start)} до ${DateTimeRepository.dateToHour(e.end)}',
            style: textTheme.headline6?.copyWith(
              fontSize: 15,
            ),
          ),
        )
        .toList();

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.home_rounded,
              size: 70,
              color: const Color(0xff6A7886),
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
                        getLocationText(),
                        textAlign: TextAlign.start,
                        style: textTheme.headline6?.copyWith(
                          fontSize: 20,
                          color: const Color(0xff2F4047),
                        ),
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

  String getLocationText() {
    String result;
    result = '$city, $street';
    if (buildingNumber?.isNotEmpty ?? false) {
      result = result + ', $buildingNumber';
    }

    return result;
  }
}
