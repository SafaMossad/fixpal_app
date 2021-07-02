import 'dart:convert';

import '../models/reviews_model.dart';

import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DangerousAlertProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  DangerousAlertProvider(this.authToken, this.userId);

  Future<void> sendDangerousAlert() async {
//_items.clear();
    Uri myUrl = Uri.parse("https://fixpalservies.herokuapp.com/api/v1/alarms");
    String body = json.encode({
      "customer_id": userId,
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
      print("Dangerous  Data ${json.decode(response.body)}");
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
