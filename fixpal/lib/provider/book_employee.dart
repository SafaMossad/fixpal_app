import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BookEmployeeProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  BookEmployeeProvider(
    this.authToken,
    this.userId,
  );

  Future<void> bookEmployee(int empId, String empName) async {
    final url =
        Uri.parse("https://fixpalservies.herokuapp.com/api/v1/contacts");
    Map<String, String> headers = {
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      'Authorization': '$authToken'
    };
    String body = json.encode({
      "employee_id": empId,
      "customer_id": userId,
      "employee_name": empName
    });
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
          'Content-Type': 'application/json',
          'Authorization': '$authToken'
        },
        body: body,
      );
      var data = json.decode(response.body);
      print("data is $data");
      if (data['errors'] != null) {
        print("response Error");
      }

      //notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
