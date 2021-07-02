
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("نبذه عن التطبيق",style: TextStyle(color: Colors.white),),
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
                "طبيق 'فيكسبال' يتيح لك امكانية طلب فني لتصليح أي مشكلة في بيتك. \n - يمكنك أيضاً تقييمهم بكل سهولة و بدون أى وسيط فقط عليك الآتي :\n - قم بتثبيت التطبيق و فتحه. \n - قم بالضغط على زر تسجيل سيظهر لك قائمة قم بملئ الخانات الموجودة أمامك و اضغط على زر إشترك. \n -قم بإختيار الحرفة و إضغط على زر بحث سيظهر لك الحريفيون الموجودون فى منطقتك بإمكانك الضغط على زر الإتصال لطلب هذا الحرفى.",
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
