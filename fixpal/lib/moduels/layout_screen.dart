import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'customer_register_screen.dart';
import 'login_screen.dart';
import 'booking_history_screen.dart';
import '../shared/styles/colors.dart';

class LayOutScreen extends StatefulWidget {
  @override
  _LayOutScreenState createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return CategoriesScreen();
        break;

      case 1:
        return BookingHistoryScreen();
        break;

      default:
        return Text("This is nothing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: defaultColor,
                size: 25,
              ),

              label: "الرئيسية",),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: defaultColor,
                size: 25,
              ),
              label: "الطلبات"),
        ],
        currentIndex: _selectedIndex,
        elevation: 10.0,
        selectedFontSize: 16.0,
        showSelectedLabels: true,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: defaultColor,
        unselectedFontSize: 13,

        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
