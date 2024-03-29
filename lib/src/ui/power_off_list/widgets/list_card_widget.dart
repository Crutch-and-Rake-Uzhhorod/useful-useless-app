import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/models/time_frame_model.dart';
import '../../../core/repository/date_time_repository.dart';

class FrameCardWidget extends StatelessWidget {
  const FrameCardWidget({
    Key? key,
    required this.city,
    required this.street,
    required this.timeFrames,
    this.buildingNumber = '',
    this.isFollowed = false,
    required this.onFollowTapped,
  }) : super(key: key);

  final String city;
  final String street;
  final String? buildingNumber;
  final List<TimeFrameModel> timeFrames;
  final bool isFollowed;
  final ValueChanged<bool?> onFollowTapped;

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

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.black.withOpacity(0.1)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(10, 12),
            blurRadius: 10,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: <Widget>[
                Icon(
                  Icons.home_outlined,
                  size: 70.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            _getLocationText(),
                            textAlign: TextAlign.start,
                            style: textTheme.headline6?.copyWith(fontSize: 18),
                          ),
                        ),
                        ...textFrames,
                      ],
                    ),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () => onFollowTapped(!isFollowed),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO: navigate to map
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text('Показати на мапі'),
                  // ),
                  const Spacer(),
                  // TODO: Localization
                  Text('Відстежувати'),
                  Checkbox(
                    value: isFollowed,
                    onChanged: onFollowTapped,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocationText() {
    String result;
    result = '$city $street';
    if (buildingNumber?.isNotEmpty ?? false) {
      result = result + ', $buildingNumber';
    }

    return result;
  }
}
