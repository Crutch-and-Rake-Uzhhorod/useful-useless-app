import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

import '../../global/constants.dart';
import '../models/local_json_parse/region_model.dart';

class ManualCityChoiceRepository {
  List<String> get listOfCities => _city.toList();

  List<String> get listOfRegions => _region.toList();

  final Set<String> _city = {};
  final Set<String> _region = {};

  final Map<String, RegionsDataModel> _cache = {};

  Future<RegionsDataModel?> getCityFromJson({required String city}) async {
    if (city.isEmpty) {
      return null;
    }
    try {
      if (!_cache.containsKey(city)) {
        ///get data from local json
        final data = await jsonDecode(
          await rootBundle.loadString(_getLocalCityToLoad(city: city)),
        );

        if (data == null) {
          return null;
        }

        final regionsData = RegionsDataModel.fromJson(data);
        _cache[city] = regionsData;

        ///get lists of regions and cities
        if (regionsData.data?.isNotEmpty ?? false) {
          regionsData.data?.forEach((regionData) {
            if (regionData.region != null && regionData.cities != null) {
              _region.add(regionData.region!);
              _city.addAll(regionData.cities!);
            }
          });
        }
      }

      return _cache[city];
    } catch (e) {
      log('$e');
    }
  }

  String getAreaByRegion({required String region}) {
    //ignore:omit_local_variable_types
    String result = '';

    _cache.forEach((key, value) {
      if (value.data?.firstWhereOrNull((e) => e.region == region) != null) {
        result = key;
      }
    });

    return result;
  }

  String getAreaByCity({required String city}) {
    //ignore:omit_local_variable_types
    String result = '';

    _cache.forEach((key, value) {
      if (value.data
          ?.firstWhereOrNull((e) => e.cities?.contains(city) ?? false) !=
          null) {
        result = key;
      }
    });

    return result;
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
