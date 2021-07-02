import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  String _userName;
  String _userEmail;

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get userEmail {
    return _userEmail;
  }

  String get userName {
    return _userName;
  }

  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse("https://fixpalservies.herokuapp.com/api/v1/sessions");
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = json.encode({"email": "$email", "password": "$password"});
    try {
      // make POST request
      final response = await http.post(url, headers: headers, body: body);

      var data = json.decode(response.body);
      print("API Response=> $data");

      if (data['errors'] != null) {
        print("hhhahahhaahahah");
        throw HttpException(data['errors']);
      }
      _token = data["auth_token"];
      _userEmail = data["email"];
      _userName = data["name"];
      _userId = data['id'].toString();
      print("data is $_token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'email':_userEmail,
          'name':_userName,
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<void> customerSignUp(
      {@required String email,
      @required String password,
      @required String phone,
      @required String name,
      @required String address}) async {
    final url =
        Uri.parse("https://fixpalservies.herokuapp.com/api/v1/customers");
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = json.encode({
      "customer": {
        "email": "$email",
        "password": "$password",
        "password_confirmation": "$password",
        "phone": "$phone",
        "name": "$name",
        "address": "$address"
      }
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      var data = json.decode(response.body);
      print("API Response=> $data");

      if (data['errors'] != null) {
        print("hhhahahhaahahah");
        throw HttpException(data['errors']);
      }
      _token = data["auth_token"];
      _userEmail = data["email"];
      _userName = data["name"];
      _userId = data['id'].toString();
      print("data is $_token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'email':_userEmail,
          'name':_userName,
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> employeeSignUp(
      {File imageFile,
      String email,
      String password,
      String name,
      String phone,
      String description,
      String category,
      String address}) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse("https://fixpalservies.herokuapp.com/api/v1/employees");
    // create multipart request
    var request = new http.MultipartRequest(
      "POST",
      uri,
    );
    // multipart that takes file
    var multipartFile = new http.MultipartFile('avatar', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = password;
    request.fields['first_name'] = name;
    request.fields['last_name'] = "none";
    request.fields['phone'] = phone;
    request.fields['address'] = address;
    request.fields['describtion'] = description;
    request.fields['Category'] = category;
    // send
    var response = await request.send();
    print("emp =>${response.statusCode}");
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print("value $value");
    });
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _userEmail = extractedUserData['email'];
    _userName = extractedUserData['name'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _userEmail = null;
    _userName = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }
}
