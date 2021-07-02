import './moduels/categories_screen.dart';
import './moduels/layout_screen.dart';
import './moduels/onBoarding_screen.dart';
import './moduels/splash_screen.dart';
import './provider/book_employee.dart';
import './provider/booking_history.dart';
import './provider/dangerous_alert.dart';
import './provider/employee_reviews_provider.dart';
import './provider/explain_provider.dart';
import './provider/auth.dart';
import './provider/employee_profile.dart';
import './provider/categories.dart';
import './provider/all_employee.dart';
import './shared/styles/themes.dart';
import 'package:provider/provider.dart';
import 'moduels/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProvider(create: (ctx) => Categories()),
          ChangeNotifierProxyProvider<Auth, BookEmployeeProvider>(
            //  child: Tabs(),
            update: (ctx, auth, previousProducts) => BookEmployeeProvider(
              auth.token,
              auth.userId,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, ExplainProvider>(
            //  child: Tabs(),
            update: (ctx, auth, previousProducts) => ExplainProvider(
              auth.token,
              auth.userId,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, AllBookingProvider>(
            //  child: Tabs(),
            update: (ctx, auth, previousProducts) => AllBookingProvider(
              auth.token,
              auth.userId,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, DangerousAlertProvider>(
            //  child: Tabs(),
            update: (ctx, auth, previousProducts) => DangerousAlertProvider(
              auth.token,
              auth.userId,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, EmployeeReviewProvider>(
            //  child: Tabs(),
            update: (ctx, auth, previousReviews) => EmployeeReviewProvider(
              auth.token,
              auth.userId,
              previousReviews == null ? [] : previousReviews.allReviews,
            ),
          ),
          ChangeNotifierProvider(create: (ctx) => all_employee()),
          ChangeNotifierProvider(create: (ctx) => EmployeeProfile()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FixPal',
            theme: appTheme,
            home: auth.isAuth
                ? LayOutScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : OnBoardingScreen(),
                  ),
          ),
        ));
  }
}
