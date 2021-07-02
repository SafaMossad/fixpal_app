import '../../../moduels/about_app.dart';
import '../../../moduels/about_us.dart';
import '../../../moduels/layout_screen.dart';
import '../../../moduels/login_screen.dart';
import '../../../moduels/explain_screen.dart';
import '../../../provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  //bool _isLoading =false;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<Auth>(
            builder: (ctx, product, _) => UserAccountsDrawerHeader(
              accountName: Text(authData.userName),
               accountEmail: Text(authData.userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "${authData.userName}",
                  style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayOutScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ارسال شكوي'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>ExplainScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('من نحن'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>AboutAUs()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('نبذة عن التطبيق'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>AboutApp()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('تسجيل الخروج'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
