import 'package:flutter/material.dart';

void main() => runApp(Welcome());

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Yono Business',

      debugShowCheckedModeBanner: false,
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'YONO BUSINESS'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
