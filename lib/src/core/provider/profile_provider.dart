import 'package:flutter/widgets.dart';

import '../repository/manual_city_choice_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required this.manualCityChoiceRepository,
  });

  late ManualCityChoiceRepository manualCityChoiceRepository;

  List<String> area = ['---', 'Львів'];
  String city = '';
  String cityArea = '';
  String areaItem = '---';

  List<String> listOfChosenCities = [];
  List<String> listOfChosenRegions = [];

  Future<void> updateAreaItem({required String newItem}) async {
    areaItem = newItem;
    notifyListeners();
    await manualCityChoiceRepository.getCityFromJson(city: newItem);
    listOfChosenCities = manualCityChoiceRepository.listOfCities;
    listOfChosenRegions = manualCityChoiceRepository.listOfRegions;
    print(listOfChosenCities[0]);
    print(listOfChosenRegions[9]);
  }
}
