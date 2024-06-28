import 'package:flutter/material.dart';

class TreatmentProvider with ChangeNotifier {
  int _maleCount = 0;
  int _femaleCount = 0;
  late String _selectedTreatment;

  int get maleCount => _maleCount;
  int get femaleCount => _femaleCount;
  String get selectedTreatment => _selectedTreatment;

  void incrementMaleCount() {
    _maleCount++;
    notifyListeners();
  }

  void decrementMaleCount() {
    if (_maleCount > 0) {
      _maleCount--;
      notifyListeners();
    }
  }

  void incrementFemaleCount() {
    _femaleCount++;
    notifyListeners();
  }

  void decrementFemaleCount() {
    if (_femaleCount > 0) {
      _femaleCount--;
      notifyListeners();
    }
  }

  void setSelectedTreatment(String treatment) {
    _selectedTreatment = treatment;
    notifyListeners();
  }

  void setCounts(int male, int female) {
    _maleCount = male;
    _femaleCount = female;
    notifyListeners();
  }
}
