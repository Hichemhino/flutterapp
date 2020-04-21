import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/sign.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/register.dart';
import 'package:flutterappcarsecur/wrapper/wrapper.dart';



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int screen_state =0;

  @override
  Widget build(BuildContext context) {
    if (screen_state == 0){
      return Register();
    }
    else if (screen_state ==1){
      return Sign();
    }
    else {
      return Wrapper();
    }

  }
}
