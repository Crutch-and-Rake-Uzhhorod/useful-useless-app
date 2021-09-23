import 'package:flutter/widgets.dart';

import '../repository/manual_city_choice_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required this.manualCityChoiceRepository,
  });

  final ManualCityChoiceRepository manualCityChoiceRepository;

  List<String> area = ['---', 'Львів'];
  String city = '';
  String cityArea = '';
  String areaItem = '---';

  List<String> get listOfChosenCities =>
      manualCityChoiceRepository.listOfCities;

  List<String> get listOfChosenRegions =>
      manualCityChoiceRepository.listOfRegions;

  Future<void> updateAreaItem({required String newItem}) async {
    areaItem = newItem;
    notifyListeners();
    await manualCityChoiceRepository.getCityFromJson(city: newItem);
  }
}
