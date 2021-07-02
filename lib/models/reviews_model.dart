import 'package:flutter/cupertino.dart';



class ReviewModel with ChangeNotifier {
  final int id;
  final String description;
  final int userId;
  final String name;
  final int customerId;
  final int employeeId;
  ReviewModel({
    @required this.id,
    @required this.description,
    @required this.userId,
    @required this.name,
    @required this.customerId,
    @required this.employeeId,
  });
}
