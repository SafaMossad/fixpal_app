import 'dart:convert';

import '../models/all_employee_model.dart';
import '../models/booking_history_model.dart';

import '../models/category_model.dart';
import '../models/feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllBookingProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  AllBookingProvider(
      this.authToken,
      this.userId,
      );
  List<BookingHistoryModel> _items = [];

  List<BookingHistoryModel> get items {
    return [..._items];
  }

  Future<List<BookingHistoryModel>> fetchAllBooking() async {
    Uri myUrl = Uri.parse(
        "https://fixpalservies.herokuapp.com/api/v1/contacts/Customer_contects");
    try {
      var response = await http.get(myUrl, headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        'Authorization': '$authToken'

      });
      print(json.decode(response.body));
      final extractedData = json.decode(response.body);

      final List<BookingHistoryModel> loadedProducts = [];

      extractedData.forEach((productData) {
        loadedProducts.add(BookingHistoryModel(
          id: productData['id'],
          createdAt: productData['created_at'],
          employeeName: productData['employee_name'],
          status: productData['status'],
        ));
      });
      print("lllllllllll  $authToken");
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print("throwed getting Booking $error");
      throw error;
    }
  }
}
