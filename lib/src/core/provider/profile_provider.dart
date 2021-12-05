import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../models/local_json_parse/region_model.dart';
import '../repository/manual_city_choice_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required ManualCityChoiceRepository manualCityChoiceRepository,
  }) : _manualCityChoiceRepository = manualCityChoiceRepository;

  final ManualCityChoiceRepository _manualCityChoiceRepository;

  RegionsDataModel? _regionsDataModel;

  final List<String> areaList = ['---', 'Львів'];

  String _area = '---';
  String _region = '';
  String _city = '';

  String get areaItem => _area;

  String get region => _region;

  String get city => _city;

  final List<String> _cities = [];

  List<String> get cities => _cities;

  List<String> get listOfRegions {
    if (_area == areaList.first) {
      return _manualCityChoiceRepository.listOfRegions;
    } else {
      return _regionsDataModel?.data
              ?.where((e) => e.region != null)
              .map((e) => e.region!)
              .toList() ??
          [];
    }
  }

  Future<void> initialiseArea({required String area}) async {
    _regionsDataModel =
        await _manualCityChoiceRepository.getCityFromJson(city: area);
  }

  Future<void> updateArea({required String newItem}) async {
    if (areaItem != newItem) {
      _area = newItem;
      _region = '';
      _city = '';

      _regionsDataModel =
          await _manualCityChoiceRepository.getCityFromJson(city: newItem);

      _cities.replaceRange(
        0,
        _cities.length,
        _manualCityChoiceRepository.listOfCities,
      );
      notifyListeners();
    }
  }

  // updates selection of area region. should get region from selected area
  // depends only on area item
  // if item is empty - update area item related to this region
  Future<void> updateRegion({required String newRegion}) async {
    if (_region != newRegion) {
      _region = newRegion;

      if (_area == areaList.first) {
        final result =
            _manualCityChoiceRepository.getAreaByRegion(region: _region);
        if (result.isNotEmpty) {
          _area = result;
        }

        _regionsDataModel =
            await _manualCityChoiceRepository.getCityFromJson(city: _area);
      }

      final regionModel = _regionsDataModel?.data?.firstWhereOrNull(
        (element) => element.region == _region,
      );
      if (regionModel != null) {
        _cities.replaceRange(
          0,
          _cities.length,
          regionModel.cities?.toList() ?? [],
        );
      } else {
        _cities.clear();
      }
      _city = '';
      notifyListeners();
    }
  }

  Future<void> updateCity({required String newCity}) async {
    if (_city != newCity) {
      _city = newCity;
      if (_city.isNotEmpty) {
        if (_area == areaList.first) {
          final result = _manualCityChoiceRepository.getAreaByCity(city: _city);
          if (result.isNotEmpty) {
            _area = result;
          }

          _regionsDataModel =
              await _manualCityChoiceRepository.getCityFromJson(city: _area);
        }

        final regionModel = _regionsDataModel?.data?.firstWhereOrNull(
          (element) => element.cities?.contains(city) ?? false,
        );

        if (regionModel == null) {
          _region = '';
        } else {
          _region = regionModel.region ?? '';
          _area = areaList.last;
        }

        notifyListeners();
      }
    }
  }
}
