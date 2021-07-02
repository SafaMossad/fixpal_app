import 'package:flutter/cupertino.dart';

class ProfileDetailsModel with ChangeNotifier {
  final int id;
  final String name;
  final String address;
  final int phone;
  final String description;
  final String image;
  final int rating;
  final int jobsNumbers;

  ProfileDetailsModel({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.image,
    @required this.jobsNumbers,
    @required this.rating,
    @required this.description,
  });
}
