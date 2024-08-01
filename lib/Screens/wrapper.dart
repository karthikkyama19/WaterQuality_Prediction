import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_2/Models/user.dart';
import 'package:tutorial_2/Screens/authenticate/authenticate.dart';
import 'package:tutorial_2/Screens/home/home.dart';

class Wrapper extends StatelessWidget {
  List<num> ab = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null){
      return Authenticate();
    }else{
      return Home(ab);
    }
  }
}
