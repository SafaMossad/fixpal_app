import '../moduels/categories_screen.dart';
import '../moduels/layout_screen.dart';

import '../provider/auth.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomerRegisterScreen extends StatefulWidget {
  @override
  _CustomerRegisterScreenState createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  bool isVisible = false;

  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  var _isLoading = false;

  Future<void> submitData(context) async {
    if (!formKey.currentState.validate()) {
      return null;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).customerSignUp(
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        address: _addressController.text,
        name: _nameController.text,
      );

      navigateAndFinish(context, LayOutScreen());

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height / 4,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    //color: iconColor,
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                 // height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Fix",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                            .copyWith(
                          color: defaultColor,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                      Text(
                        "Pal ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                            .copyWith(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                      Text(
                        "مرحبا بك في",
                        style: Theme
                            .of(context)
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
                      "سجل دخولك لايجاد أميز العمال ",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultTextFormField(
                  label: "الاسم",
                  hint: "أدخل الاسم بالكامل",
                  prefix: Icons.person,
                  type: TextInputType.visiblePassword,
                  controller: _nameController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'ادخل الاسم من فضلك';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "رقم التليفون",
                  hint: "أدخل رقم تليفونك",
                  prefix: Icons.phone,
                  type: TextInputType.visiblePassword,
                  controller: _phoneController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'من فضلك أدخل رقم تليفونك';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "العنوان",
                  hint: "أدخل العنوان",
                  prefix: Icons.home,
                  // type: TextInputType.emailAddress,
                  controller: _addressController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'ادخل عنوان صالح';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "البريد الألكتروني",
                  hint: "أدخل عنوان البريد الالكتروني",
                  prefix: Icons.email,
                  // type: TextInputType.emailAddress,
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'ادخل عنوان بريد صالح';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return "افحص كلمة المرور";
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
                  height: 10.0,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    :  defaultButton(
                  function: () =>
                 submitData(context),
                  context: context,
                  text: "تسجيل",
                  radius: 8.0,
                  background: Color(0xff40916c),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : defaultButton(
                  function: () => navigateTo(context, LoginScreen()),
                  context: context,
                  text: "العودة الي صفحة تسجيل الدخول",
                  radius: 8.0,
                  background: Color(0xff40916c),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
