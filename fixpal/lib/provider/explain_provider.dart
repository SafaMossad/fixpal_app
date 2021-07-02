import 'dart:convert';

import '../models/reviews_model.dart';

import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExplainProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  ExplainProvider(this.authToken, this.userId);

  Future<void> addExplain(String description) async {
    Uri myUrl = Uri.parse("https://fixpalservies.herokuapp.com/api/v1/reports");
    String body = json.encode({"describtion": description});

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
}
