import 'package:app_medicamentos/pages/register/name_register.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/profile/edit_profile.dart';
import 'package:app_medicamentos/pages/register/name_register.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //home: ProfilePage(),
      home: StartPage(),
    );
  }
}
