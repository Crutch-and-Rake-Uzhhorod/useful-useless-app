import 'dart:developer';

import 'package:flutter/foundation.dart';

class TabListener extends ValueNotifier<int>{
  TabListener() : super(0);

  void tabIndex(int index) {
    value = index;
    log('Tab index: $value');
  }
}
