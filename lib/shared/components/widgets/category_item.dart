import 'package:flutter/cupertino.dart';

import '../../../models/category_model.dart';
import '../../../moduels/all_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components.dart';

class CategoryItem extends StatelessWidget {
  int index;

  CategoryItem({this.index});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesModel>(context, listen: false);
    return GestureDetector(
      // onTap: () => navigateTo(context, CategoryEmployeeScreen()),
      child: Container(
        decoration: BoxDecoration(
          //border: Border.all(),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 120.0,
                child: Image.asset(
                  categories.image,
                  fit: BoxFit.cover,

                  //color: iconColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            defaultButton(
              function: () {
                navigateTo(
                    context,
                    AllEmployeeScreen(
                        index: index, appbarTitle: categories.title));
              },
              context: context,
              text: categories.title,
              radius: 8.0,
              fontSize: 16.0,
              textColor: Theme.of(context).primaryColor,
              width: 150,
              borderColor: Theme.of(context).primaryColor,
              background: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
