import 'package:flutter/material.dart';
import 'package:universities/presentation/page/form_page.dart';
import 'package:universities/presentation/page/home_page.dart';
import 'package:universities/presentation/page/login_page.dart';
import 'package:universities/presentation/page/university_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> appRoutes(BuildContext context) {
    return {
      '/formPage': (context) => const FormPage(),
      '/universityPage': (context) => const UniversityPage(),
      '/homePage':(context) => const HomePage(),
      '/loginPage':(context) =>  const LoginPage(),
    };
  }
}
