import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  late PageController _pageViewController;

  int get selectedIndex => _selectedIndex;
  PageController get pageViewController => _pageViewController;
  TabController get tabController => _tabController;

  void init (vsync) {
    _pageViewController = PageController(keepPage: true);
    _tabController = TabController(length: 4, vsync: vsync);
  }

  void updateCurrentPageIndex(int index) {
    _tabController.index = index;
     _selectedIndex = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageViewController.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedIndex', selectedIndex));
  }
}