import '../provider/explain_provider.dart';
import '../shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ExplainScreen extends StatefulWidget {
  @override
  _ExplainScreenState createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('شكرا لك'),
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

  Future<void> _submit() async {
    // print("submit clicked");
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
      await Provider.of<ExplainProvider>(context, listen: false)
          .addExplain(_reviewController.text);
      _showErrorDialog("تم ارسال شكواك بنجاح");
    } catch (error) {
      print("messsssage $error");

      const errorMessage = 'هناك مشكلة ما سوف يتم حلها في اقؤب وقت.';
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 4,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right:11.0),
                  alignment: Alignment.topRight,
                  child: Text(
                    "أكتب شكواك",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 160.0,
                  child: defaultTextFormField(
                    label: "شكوي",
                    hint: "اكتب شكواك",
                    maxLines: 6,
                    prefix: Icons.description,
                    type: TextInputType.text,
                    controller: _reviewController,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'اكتب شكواك صحيحة!';
                      }
                    },
                  ),
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : defaultButton(
                        function: () {
                          _submit();
                          _reviewController.clear();
                        },
                        context: context,
                        text: "ارسال الشكوي",
                        isUpperCase: false,
                        radius: 8.0,
                        background: Theme.of(context).primaryColor,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
