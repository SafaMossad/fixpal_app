import 'package:flutter/cupertino.dart';

class BookingHistoryModel with ChangeNotifier {
  final int id;
  final String employeeName;
  final String status;
  final String createdAt;

  BookingHistoryModel({
    @required this.id,
    @required this.employeeName,
    @required this.status,
    @required this.createdAt,
  });
}
