import 'dart:developer';

import 'package:flutter/material.dart';

class PageBusiness {
  late BuildContext _context;
  late Key _pageKey;
  PageBusiness(BuildContext context, Key? pageKey) {
    _context = context;
    if (pageKey != null) {
    _pageKey = pageKey;
    }
  }

  void mounted (Function() onMounted) {
    var isMounted =
        PageStorage.of(_context).readState(_context, identifier: _pageKey) ??
            false;
    if (!isMounted) {
      PageStorage.of(_context).writeState(_context, true, identifier: _pageKey);
      PageStorageKey pk = _pageKey as PageStorageKey;
      log('${pk.value.toString()} Mounted');
      onMounted();
    }
  }
}
