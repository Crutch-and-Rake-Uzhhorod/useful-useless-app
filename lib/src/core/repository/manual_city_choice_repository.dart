import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../../global/constants.dart';

class ManualCityChoiceRepository {
  List<String> get listOfCities => _city;
  List<String> get listOfRegions => _region;

  List<String> _city = [];
  List<String> _region = [];

  Future<void> getCityFromJson({required String city}) async {
    try {
      List<String> dirtyCity = [];
      List<String> dirtyRegion = [];

      ///get data from local json
      final data = await jsonDecode(
        await rootBundle.loadString(_getLocalCityToLoad(city: city)),
      );
      final jsonQuestions = data['data'] as List;

      ///get lists of regions and cities
      if (jsonQuestions.isNotEmpty) {
        for (int i = 0; i < jsonQuestions.length; i++) {
          dirtyRegion.add(
            jsonQuestions[i][0],
          );

          dirtyCity.add(
            jsonQuestions[i][1],
          );
        }

        ///clear same values
        ///sort unique values
        _region = dirtyRegion.toSet().toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
        _city = dirtyCity.toSet().toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      }
    } catch (e) {
      log('error');
      rethrow;
    }
  }

  String _getLocalCityToLoad({required String city}) {
    switch (city) {
      case 'Львів':
        return lvivRegion;
      default:
        return '';
    }
  }
}
