import 'dart:io';

import 'layout_screen.dart';
import '../provider/auth.dart';
import 'package:provider/provider.dart';

import 'categories_screen.dart';
import 'customer_register_screen.dart';
import 'employee_register_screen.dart';
import '../shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';

import '../shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;
  bool isVisible = false;

  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'This is Not a Valid Email',
          style: TextStyle(color: Colors.indigo),
        ),
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

  Future<void> submitData(context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );
      navigateAndFinish(context, LayOutScreen());
      setState(() {
        _isLoading = true;
      });
    } on HttpException catch (error) {
      var errorMessage = 'Please Enter a Valid Account';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error
          .toString()
          .contains(' "errors": "Invalid email or password"')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(",esssssage $error");
      setState(() {
        _isLoading = false;
      });
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 4,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                      //color: iconColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 40.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Fix",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: defaultColor,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                            ),
                      ),
                      Text(
                        "Pal ",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                            ),
                      ),
                      Text(
                        "مرحبا بك في",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: defaultColor),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "سجل دخولك لايجاد أميز الحرفيين ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                defaultTextFormField(
                  label: "عنوان البريد الالكتروني",
                  hint: "أدخل عنوان البريد الالكتروني",
                  prefix: Icons.email,
                  // type: TextInputType.emailAddress,
                  controller: _emailController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'ادخل عنوان بريد صالح';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return "Enter Valid Password";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      obscureText: isVisible
                          //&& "Enter Your Password" == 'Enter Your Password'
                          ? true
                          : false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0),
                        )),
                        labelText: "كلمة المرور",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        hintText: "أدخل كلمة المرور",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: isVisible
                            //&& 'Enter Your Password' == 'Enter Your Password'
                            ? IconButton(
                                icon: Icon(Icons.visibility_off),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    isVisible = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.visibility),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    isVisible = true;
                                  });
                                }),
                      )),
                ),
                SizedBox(
                  height: 25.0,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : defaultButton(
                        function: () => submitData(context),
                        context: context,
                        text: "تسجيل الدخول",
                        radius: 8.0,
                        background: Color(0xff40916c),
                      ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      defaultTextButton(
                          text: "سجل الأن",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                          function: () {
                            navigateTo(context, CustomerRegisterScreen());
                          }),
                      Text(
                        "ليس لديك حساب؟",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 10.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        defaultButton(
                          context: context,
                          width: 150,
                          fontSize: 14,
                          text: "الانضمام الي الفريق",
                          radius: 8.0,
                          function: () => navigateTo(context, RegisterScreen()),
                          background: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
