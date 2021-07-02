import '../provider/dangerous_alert.dart';
import '../shared/components/widgets/app_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../provider/categories.dart';
import '../shared/components/widgets/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Categories>(context);
    final categories = categoriesData.items;
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "All Categories",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.red,
                size: 30.0,
              ),
              onPressed: () {
                Provider.of<DangerousAlertProvider>(context, listen: false)
                    .sendDangerousAlert();
                Fluttertoast.showToast(
                  msg: " تم ارسال اشعار الخطر بنجاح!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GridView.builder(
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: categories[index],
                  child: CategoryItem(index: index),
                ),
                itemCount: categories.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.15,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
