import 'package:bt_match/utils/constants.dart';
import 'package:bt_match/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'BT Match',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kCustomColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen());
  }
}
