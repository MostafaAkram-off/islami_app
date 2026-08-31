import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeth_model.dart';

class HadethDetailsScreen extends StatelessWidget {
  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HadethModel hadeth = ModalRoute.of(context)?.settings.arguments as HadethModel;
    return Scaffold();
  }
}
