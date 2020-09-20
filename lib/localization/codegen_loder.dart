import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ua_UA = {
  'title': 'Виберіть мову',
  'map': 'Мапа',
    'list': 'Список',
  'profile': 'Профіль'
    };

  static const Map<String,dynamic> ru_RU = {
    'title': 'Выберите язык',
    'map': 'Карта',
    'list': 'Список',
    'profile': 'Профиль'
  };


  static const Map<String, Map<String,dynamic>> mapLocales = {'ua_UA': ua_UA,  'ru_RU': ru_RU, };

}