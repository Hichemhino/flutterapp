import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signemail.dart';
import 'package:flutterappcarsecur/wrapper/home/page2.dart';



class Authenticate extends StatefulWidget {
  bool etat;
  Authenticate({this.etat});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //int screen_state =0;
  @override
  Widget build(BuildContext context) {
    if (widget.etat == false){
      return Suite();
    }
    else{
      return Sign();
    }

  }
}
