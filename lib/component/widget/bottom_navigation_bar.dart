import 'package:flutter/material.dart';
import 'package:the_smart_workshop/component/const/colors.dart';
import 'package:the_smart_workshop/screens/a_home/home_screen/a_home.dart';
import 'package:the_smart_workshop/screens/a_home/screens/about_us/about_us.dart';
import 'package:the_smart_workshop/screens/a_home/screens/call_us/call_us.dart';
import 'package:the_smart_workshop/screens/a_home/screens/policy/policy.dart';
import 'package:the_smart_workshop/screens/a_home/screens/support_us/support_us.dart';

class MyBottomAppBar {
  final int i;
  final String title;
  final IconData icon;
  final Color color;
  final String onPressed;

  MyBottomAppBar(
      {required this.i,
      required this.title,
      required this.icon,
      required this.color,
      required this.onPressed});
}

List<MyBottomAppBar> myBottomAppBar = [
  MyBottomAppBar(
      i: 0,
      title: "الرئيسية",
      icon: Icons.home,
      color: cLogoColorW,
      onPressed: MyHomePage.id),
  MyBottomAppBar(
      i: 1,
      title: "إدعمنا",
      icon: Icons.supervised_user_circle,
      color: Colors.teal,
      onPressed: SupportUs.id),
  MyBottomAppBar(
      i: 2,
      title: "من نحن",
      icon: Icons.account_box,
      color: Colors.blue,
      onPressed: AboutUs.id),
  MyBottomAppBar(
      i: 3,
      title: "الخصوصية",
      icon: Icons.local_police,
      color: Colors.green,
      onPressed: Policy.id),
  MyBottomAppBar(
      i: 4,
      title: "تواصل معنا",
      icon: Icons.wifi_calling,
      color: Colors.purple,
      onPressed: CallUs.id),
];
