import 'package:flutter/material.dart';
import 'package:yonobusiness/views/CorporateCustomerLogin.dart';
import 'package:yonobusiness/views/SpalshScreen.dart';

void main() => runApp(MyApp1());

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name

      debugShowCheckedModeBanner: false,
      // Application theme data, you can set the colors for the application as
      // you wan
      // A widget which will be started on application startup
      //home: MyHomePage(title: 'YONO BUSINESS'),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => CorporateLoginPage(),
      },
    );
  }
}
