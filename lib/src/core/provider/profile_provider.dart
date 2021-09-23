import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../models/local_json_parse/region_model.dart';
import '../repository/manual_city_choice_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required this.manualCityChoiceRepository,
  });

  final ManualCityChoiceRepository manualCityChoiceRepository;

  List<String> area = ['---', 'Львів'];
  String areaItem = '---';

  RegionsDataModel? _regionsDataModel;

  List<String> get listOfChosenCities =>
      manualCityChoiceRepository.listOfCities;

  List<String> get listOfChosenRegions {
    final list = <String>[];

    if (_regionsDataModel?.data?.isNotEmpty ?? false) {
      _regionsDataModel?.data?.forEach((element) {
        if (element.region?.isNotEmpty ?? false) {
          list.add(element.region!);
        }
      });
    }

    return list;
  }

  List<String> getCitiesByRegion(String region) {
    return _regionsDataModel?.data
            ?.firstWhereOrNull(
              (element) => element.region == region,
            )
            ?.cities
            ?.toList() ??
        [];
  }

  Future<void> updateAreaItem({required String newItem}) async {
    areaItem = newItem;
    notifyListeners();
    _regionsDataModel =
        await manualCityChoiceRepository.getCityFromJson(city: newItem);
  }
}
