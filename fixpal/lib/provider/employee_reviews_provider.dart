import 'dart:convert';

import '../models/reviews_model.dart';

import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeReviewProvider with ChangeNotifier {
  final String authToken;
  final String userId;
  List<ReviewModel> _allReviews = [];

  EmployeeReviewProvider(this.authToken, this.userId, this._allReviews);

  List<ReviewModel> get allReviews {
    return [..._allReviews];
  }

  Future<void> addReview(String description, int customerId) async {
//_items.clear();
    Uri myUrl = Uri.parse("https://fixpalservies.herokuapp.com/api/v1/reviews");
    String body = json.encode({
      "employee_id": userId,
      "customer_id": "$customerId",
      "describtion": "$description"
    });

    try {
      var response = await http.post(myUrl,
          headers: {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Content-Type': 'application/json',
            'Authorization': '$authToken'
          },
          body: body);
      print("review Added ${json.decode(response.body)}");
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<ReviewModel>> fetchAllReviews(int id) async {


    Uri myUrl = Uri.parse(
        "https://fixpalservies.herokuapp.com/api/v1/reviews/employee_review?employee_id=$id");
    try {
      var response = await http.get(myUrl, headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      });
      print(json.decode(response.body));
      print(json.decode(response.body));
      final extractedData = json.decode(response.body);
      //print(extractedData["user"]["name"]);
      final List<ReviewModel> loadedProducts = [];
      extractedData.forEach((reviewData) {
        loadedProducts.add(ReviewModel(
          id: reviewData["id"],
          name: reviewData["customer"]["name"].toString(),
          description: reviewData["describtion"],
          customerId: reviewData["customer_id"],
          userId: reviewData["user_id"],
        ));
      });
      print(" testgasjdhahjas hahahhhahaha$extractedData");
      _allReviews = loadedProducts;
      notifyListeners();
    } catch (error) {
      print("اش ثققخق$error");
      throw error;
    }
  }
}
