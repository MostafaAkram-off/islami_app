import 'package:flutter/material.dart';
import 'package:islami_app/ui/home/screen/home_screen.dart';
import 'package:islami_app/ui/sura_details/screen/sura_details_screen.dart';

import 'core/resources/routes_manger.dart';

void main() {
runApp(Islami());
}

class Islami extends StatelessWidget {
  const Islami({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        RoutesManger.homeRouteName: (context) => const HomeScreen(),
        RoutesManger.suraDetailsRouteName: (context) => const SuraDetailsScreen(),
      } ,
      initialRoute: RoutesManger.homeRouteName,
    );
  }
}