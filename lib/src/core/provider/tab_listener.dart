import 'dart:developer';

import 'package:flutter/foundation.dart';

class TabListener {
  ValueNotifier indexedTab = ValueNotifier(0);
  void tabIndex(int index) {
    indexedTab.value = index;
    log('${indexedTab.value}');
  }
}
