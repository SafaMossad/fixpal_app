import '../models/all_employee_model.dart';
import '../models/reviews_model.dart';
import '../provider/book_employee.dart';
import '../provider/employee_reviews_provider.dart';
import '../provider/explain_provider.dart';

import '../provider/employee_profile.dart';
import 'package:provider/provider.dart';

import '../models/feeds_model.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmployeeProfileScreen extends StatefulWidget {
  EmployeeProfileModel userData;

  EmployeeProfileScreen({@required this.userData});

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Thank You'),
        content: Text(message),
        actions: <Widget>[
          MaterialButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    print("submit clicked");
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print("not valid");
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      Provider.of<EmployeeReviewProvider>(context, listen: false)
          .addReview(controller.text, widget.userData.id);
      _showErrorDialog("Review Sent Successfully");
    } catch (error) {
      print("message $error");

      const errorMessage = 'Could Send Your review. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
/*    final employeeData = Provider.of<EmployeeProfile>(context,listen: false);
    final employee = employeeData.items;*/
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        titleSpacing: 20.0,
        centerTitle: true,
        title: Text("FixPal",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(letterSpacing: 8.0, color: Colors.white)),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                // height: size.height/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 170.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: defaultButton(
                                radius: 8.0,
                                // width: 150.0,
                                function: () {
                                  Provider.of<BookEmployeeProvider>(context,
                                          listen: false)
                                      .bookEmployee(widget.userData.id,
                                          widget.userData.firstName)
                                      .then((value) {});

                                  Scaffold.of(context).hideCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      content: Text(
                                        ' تم الطلب بنجاح!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(color: Colors.white),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                text: "احجز الان",
                                context: context,
                                fontSize: 17.0,
                                borderColor: defaultColor,
                                background: Color(0xff40916c),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10.0,
                            child: Container(
                              height: 80.0,
                              padding: EdgeInsets.symmetric(
                                horizontal: 50.0,
                                vertical: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'عدد الطلبات',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        widget.userData.jobsNumbers.toString(),
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        'التليفون',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        widget.userData.phone,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Card(
                              color: Colors.white,
                              elevation: 10.0,
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(30.0),
                                child: Text(
                                  widget.userData.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 20.0),
                            alignment: Alignment.topRight,
                            child: Text(
                              "المراجعة",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FutureBuilder(
                              future: Provider.of<EmployeeReviewProvider>(
                                      context,
                                      listen: false)
                                  .fetchAllReviews(widget.userData.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  print("waiting");
                                  return LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    semanticsLabel: 'Linear progress indicator',
                                  );
                                } else {
                                  if (snapshot.hasError) {
                                    print(
                                        "error snap  error ${snapshot.error}");
                                    return Center(
                                      child: Text('An error occurred!'),
                                    );
                                  } else {
                                    print("success $snapshot");
                                    return Consumer<EmployeeReviewProvider>(
                                      builder: (ctx, oneReviewData, _) =>
                                          SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          //if(n % 2 == 0)
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: (index % 2 == 0)
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Colors.white
                                                      .withOpacity(0.5),
                                            ),
                                            child: buildReviewItem(
                                                context,
                                                oneReviewData
                                                    .allReviews[index]),
                                          ),
                                          separatorBuilder: (context, index) =>
                                              Column(
                                            children: [
                                              SizedBox(
                                                height: 10.0,
                                              )
                                            ],
                                          ),
                                          itemCount:
                                              oneReviewData.allReviews.length,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: defaultTextFormField(
                                      maxLines: 5,
                                      onTap: null,
                                      //suffix:  Icons.comment,
                                      controller: controller,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "errrrror";
                                        }
                                        return null;
                                      },
                                      label: " اضافة مراجعة جديد ......",
                                      prefix: Icons.comment,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultButton(
                                    function: () => _submit(),
                                    context: context,
                                    text: "ارسال المراجعة",
                                    radius: 8.0,
                                    background: Color(0xff40916c),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, right: 50.0, left: 50.0),
              child: Card(
                color: Colors.white,
                elevation: 10.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Container(
                  height: size.height / 3,
                  width: size.width / 2 + 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                            widget.userData.image,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        widget.userData.firstName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).primaryColor, height: 0.2),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (widget.userData.rating == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_border,
                              color: defaultColor,
                            ),
                          ],
                        ),
                      if (widget.userData.rating == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: defaultColor,
                            ),
                          ],
                        ),
                      if (widget.userData.rating == 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      if (widget.userData.rating == 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      if (widget.userData.rating == 4)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      if (widget.userData.rating == 5)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.userData.address,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.grey, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final String imageLink =
      "https://images.unsplash.com/photo-1505798577917-a65157d3320a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";

  Widget buildReviewItem(context, ReviewModel model) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${model.name}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${model.description}",
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      );
}
