import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/user/user.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/register.dart';
import 'package:provider/provider.dart';
import 'wrapper/wrapper.dart';




void main() => runApp(MaterialApp(home: Home()),);

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Register();
  }
}