import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutAUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("من نحن",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                "مجموعه من الشباب المتطوعين من اجل توفير فرص عمل من اجل الحرفين بجانب مساعد العملاء فى التواصل مع افضل الحرفين مع برنامج غير هادف ل اى نوع من انواع الربح",
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
