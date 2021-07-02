import 'dart:convert';

import '../models/all_employee_model.dart';

import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class all_employee with ChangeNotifier {
  List<EmployeeProfileModel> _items = [
  ];

  List<EmployeeProfileModel> get items {
    return [..._items];
  }

  Future<List<EmployeeProfileModel>> fetchItems(int index) async {
    Uri myUrl = Uri.parse(
        "https://fixpalservies.herokuapp.com/api/v1/employees/get_all?index=$index");
    try {
      var response = await http.get(myUrl, headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      });
      print(json.decode(response.body));
      final extractedData = json.decode(response.body);

      final List<EmployeeProfileModel> loadedProducts = [];

      extractedData.forEach((productData) {
        loadedProducts.add(EmployeeProfileModel(
          id: productData['id'],
          image:productData['avatar_url'],
          firstName: productData['first_name'],
          lastName: productData['last_name'],
          phone: productData['phone'],
          description: productData['describtion'],
          address: productData['address'],
          jobsNumbers: productData['jobnum'],
          rating: productData['rating'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print("r=throwed getting error $error");
      throw error;
    }
  }
}
