import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  List<CategoriesModel> _items = [
    CategoriesModel(
      id: 1,
      title: "نجار باب و شباك",
      image: 'assets/categories/nagar.png',
    ),
    CategoriesModel(
      id: 2,
      title: "عامل نظافه",
      image: 'assets/categories/cleaner.png',
    ),
    CategoriesModel(
      id: 3,
      title: "استورجي",
      image: 'assets/categories/astorgy.png',
    ),
    CategoriesModel(
      id: 4,
      title: "منجد",
      image: 'assets/categories/mnaged.png',
    ),
    CategoriesModel(
      id: 5,
      title: "نقاش",
      image: 'assets/categories/nakash.png',
    ),
    CategoriesModel(
      id: 6,
      title: "فني تكييف",
      image: 'assets/categories/fanytakef.png',
    ),
    CategoriesModel(
      id: 7,
      title: "فني دش ",
      image: 'assets/categories/fanydesh.png',
    ),
    CategoriesModel(
      id: 8,
      title: "فني تركبي موكيت",
      image: 'assets/categories/fanysegad.png',
    ),
    CategoriesModel(
      id: 9,
      title: "‎فني كومبيوتر",
      image: 'assets/categories/fanycomputer.png',
    ),
  ];

  List<CategoriesModel> get items {
    return [..._items];
  }
}
