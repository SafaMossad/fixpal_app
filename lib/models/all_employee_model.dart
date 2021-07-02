import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class EmployeeProfileModel with ChangeNotifier {
  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  final String description;
  final String image;
  final int rating;
  final int jobsNumbers;

  EmployeeProfileModel({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.phone,
    @required this.address,
    @required this.image,
    @required this.jobsNumbers,
    @required this.rating,
    @required this.description,
  });
}
