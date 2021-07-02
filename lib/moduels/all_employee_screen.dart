import 'dart:ui';

import '../models/all_employee_model.dart';
import '../moduels/employee_profile_screen.dart';
import '../provider/book_employee.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../provider/all_employee.dart';

import '../models/feeds_model.dart';
import '../provider/categories.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AllEmployeeScreen extends StatelessWidget {
  final int index;
  final String appbarTitle;

  AllEmployeeScreen({this.index, this.appbarTitle});

  bool isLoading = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*  final categoryEmployee = Provider.of<Feeds>(context);
    final employee = categoryEmployee.items;*/
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 12.0,
          titleSpacing: 20.0,
          centerTitle: true,
          title: Text(
            appbarTitle,
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<all_employee>(context, listen: false)
                .fetchItems(index),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("waiting");
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  print("error snap  error  error${snapshot.error}");
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  print("success $snapshot");
                  return Consumer<all_employee>(
                    builder: (ctx, feedsData, child) => feedsData.items.length >
                            0
                        ? SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: (index % 2 == 0)
                                            ? Colors.grey.withOpacity(0.2)
                                            : Colors.white.withOpacity(0.5),
                                      ),
                                      child: buildEmployeeItem(
                                          context, feedsData.items[index])),
                                  itemCount: feedsData.items.length,
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              "لا يوجد عمال الان \n سوف يتم اضافة مزيد من العمال قريبا.",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                      ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                  );
                }
              }
            }));
  }

  Widget buildEmployeeItem(context, EmployeeProfileModel user) => Column(
        children: [
          InkWell(
            onTap: () =>
                navigateTo(context, EmployeeProfileScreen(userData: user)),
            child: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 21.0, left: 18.0),
                              child: defaultButton(
                                borderColor: Theme.of(context).primaryColor,
                                function: () {
                                  Provider.of<BookEmployeeProvider>(context,
                                          listen: false)
                                      .bookEmployee(user.id, user.firstName);
                                  Fluttertoast.showToast(
                                    msg: " تم ارسال الطلب بنجاح",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                                text: "احجز الان",
                                context: context,
                                width: 100.0,
                                radius: 15.0,
                                textColor: Theme.of(context).primaryColor,
                                background: Colors.transparent,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "${user.firstName}",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: greenColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),

                                  /*  SizedBox(
                                    height: 10.0,
                                  ),*/
                                  if (user.rating == 0)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star_border,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  if (user.rating == 1)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  if (user.rating == 2)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  if (user.rating == 3)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  if (user.rating == 4)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  if (user.rating == 5)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  Text(
                                    user.jobsNumbers.toString(),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            //for red dot and picture
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, right: 8.0),
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(user.image),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
