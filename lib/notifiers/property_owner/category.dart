import 'package:findhouse/helpers/category.dart';
import 'package:findhouse/models/category.dart';
import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  List<String> categoriesNames = [];
  String selectedCategory;

  CategoryProvider.initialize(){
    loadCategories();
  }

  loadCategories()async{
    categories = await _categoryServices.getCategories();
    for(CategoryModel category in categories){
      categoriesNames.add(category.name);
    }
    selectedCategory = categoriesNames[0];
    notifyListeners();
  }

  changeSelectedCategory({String newCategory}){
    selectedCategory = newCategory;
    notifyListeners();
  }
}