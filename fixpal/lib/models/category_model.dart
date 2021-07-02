import 'package:flutter/cupertino.dart';

class CategoriesModel with ChangeNotifier {
  final String title;
  final int id;
  final String image;

  CategoriesModel({
    @required this.id,
    @required this.title,
    @required this.image,
  });
}
