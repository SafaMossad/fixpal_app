import 'dart:io';
import 'dart:ui';

import '../moduels/categories_screen.dart';
import '../moduels/login_screen.dart';
import '../provider/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _avatarController = TextEditingController();
  String fieldDropdownValue = 'نجار باب وشباك';

  // To show Selected Item in Text.
  String fieldHolder = '';

  List<String> fieldItems = [
    'نجار باب وشباك',
    'عامل نظافة',
    "استورجي",
    "منجد",
    "نقاش",
    "فني تكيف",
    "فني دش",
    "فني موكيت",
    "فني كمبيوتر"
  ];

/*  void getDropDownItemDegree() {
    setState(() {
      fieldHolder = fieldDropdownValue;
    });
  }*/

  Widget _field() {
    return Container(
      alignment: Alignment.center,
      //decoration: kBoxDecorationStyle,
      height: 65.0,
      //padding: EdgeInsets.only(top: 3.0),
      // width: 150.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                //width: 150.0,
                child: DropdownButton<String>(
                  value: fieldDropdownValue,
                  isDense: true,
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                  ),
                  iconSize: 22,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      //fontFamily: 'co',
                      fontSize: 17.0),
                  onChanged: (String data) {
                    setState(() {
                      fieldDropdownValue = data;
                      if (data == "نجار باب وشباك") {
                        fieldHolder = "نجار باب وشباك";
                      } else if (data == "عامل نظافة") {
                        fieldHolder = "care";
                      } else if (data == "استورجي") {
                        fieldHolder = "astorgy";
                      } else if (data == "منجد") {
                        fieldHolder = "mnagad";
                      } else if (data == "نقاش") {
                        fieldHolder = "naqash";
                      } else if (data == "فني تكيف") {
                        fieldHolder = "fanytakef";
                      } else if (data == "فني موكيت") {
                        fieldHolder = "fanydash";
                      } else if (data == "فني موكيت") {
                        fieldHolder = "fanymokat";
                      } else if (data == "فني كمبيوتر") {
                        fieldHolder = "fanycomputer";
                      }
                      print(fieldDropdownValue);
                      print(fieldHolder);
                    });
                  },
                  items:
                      fieldItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("مجال العمل",
                  style: TextStyle(
                      color: Color(0xFF8b8b8b),
                      fontSize: 15.0,
                      fontFamily: 'co',
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(
              width: 15.0,
            ),
            Icon(
              Icons.category,
              color: Color(0xFF8b8b8b),
            ),
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image  = $_image');
      } else {
        print('No image selected. sorry');
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          '.سوف يتم التواصل مع قريبا',
          style: TextStyle(color: Colors.indigo),
        ),
        content: Text(message),
        actions: <Widget>[
          MaterialButton(
            child: Text('تم'),
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
      await Provider.of<Auth>(context, listen: false).employeeSignUp(
        imageFile: _image,
        address: _addressController.text,
        description: _descriptionController.text,
        phone: _phoneController.text,
        name: _firstNameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        category: fieldHolder,
      );
      _showErrorDialog("شكرا لك علي الانضمام الي فريقنا");
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height / 7,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    //color: iconColor,
                  ),
                ),
                /* Container(
                  height: 40.0,
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
                ),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "سجل دخولك لايجاد أكثر من فرصة عمل  ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: Colors.white,
                  //height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60.0,
                          backgroundImage: _image == null
                              ? NetworkImage(
                                  'https://image.flaticon.com/icons/png/512/2102/2102647.png',
                                )
                              : FileImage(_image),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      IconButton(
                          icon: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 40.0,
                            child: Icon(
                              Icons.camera_alt,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _pickImage),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "الاسم",
                  hint: "أدخل الاسم بالكامل",
                  prefix: Icons.person,
                  type: TextInputType.visiblePassword,
                  controller: _firstNameController,
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
                  type: TextInputType.visiblePassword,
                  controller: _addressController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return ' من فضلك أدخل العنوان';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "الوصف",
                  hint: "أدخل الوصف",
                  prefix: Icons.home,
                  type: TextInputType.visiblePassword,
                  controller: _descriptionController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return ' من فضلك أدخل الوصف';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: _field(),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                      border: Border.all(color: Colors.grey)),
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
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'ادخل عنوان بريد صالح';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  label: "كلمة المرور",
                  hint: "أدخل كلمة المرور",
                  prefix: Icons.lock_outline,
                  type: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'كلمة المرو قصيرة';
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : defaultButton(
                        function: () => submitData(context),
                        context: context,
                        text: "تسجيل",
                        radius: 8.0,
                        background: Color(0xff40916c),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                defaultButton(
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
