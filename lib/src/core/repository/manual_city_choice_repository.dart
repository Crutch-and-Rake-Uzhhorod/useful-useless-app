import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:useful_useless_app/src/core/models/local_json_parse/region_model.dart';

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

      if (data == null) {
        return;
      }

      final regionsData = RegionsDataModel.fromJson(data);

      ///get lists of regions and cities
      if (regionsData.data?.isNotEmpty ?? false) {
        regionsData.data?.forEach((regionData) {
          if (regionData.region != null && regionData.cities != null) {
            _region.add(regionData.region!);
            _city.addAll(regionData.cities!);
          }
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
