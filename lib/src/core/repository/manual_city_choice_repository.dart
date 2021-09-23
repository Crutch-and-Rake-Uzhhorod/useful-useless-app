import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

import '../../global/constants.dart';

class ManualCityChoiceRepository {
  List<String> get listOfCities => _city;

  List<String> get listOfRegions => _region;

  final List<String> _city = [];
  final List<String> _region = [];

  Future<void> getCityFromJson({required String city}) async {
    if (city.isEmpty) {
      _city.clear();
      _region.clear();

      return;
    }
    try {
      ///get data from local json
      final data = await jsonDecode(
        await rootBundle.loadString(_getLocalCityToLoad(city: city)),
      );

      ///raw map of regions
      final jsonMap = data['data'];

      ///get lists of regions and cities
      if (jsonMap.isNotEmpty) {
        jsonMap.forEach((key, value) {
          _region.add(key);
          final rawList = value as List<dynamic>;
          rawList.forEach((element) {
            _city.add(element as String);
          });
        });
      }
    } catch (e) {
      log('error');
      _city.clear();
      _region.clear();
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
