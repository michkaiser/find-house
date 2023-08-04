import 'dart:collection';
import 'package:findhouse/models/properties.dart';
import 'package:flutter/cupertino.dart';

class PropertyNotifier with ChangeNotifier {
  List<Properties> _propertiesList = [];
  Properties _currentProperty;

  UnmodifiableListView<Properties> get propertiesList => UnmodifiableListView(_propertiesList);

  Properties get currentProperty => _currentProperty;

  set propertiesList(List<Properties> propertiesList) {
    _propertiesList = propertiesList;
    notifyListeners();
  }

  set currentProperty(Properties properties) {
    _currentProperty = properties;
    notifyListeners();
  }

  addProperty(Properties properties) {
    _propertiesList.insert(0, properties);
    notifyListeners();
  }

  deleteProperty(Properties properties) {
    _propertiesList.removeWhere((_properties) => _properties.id == properties.id);
    notifyListeners();
  }
}