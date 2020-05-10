import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registeremail.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registerphone.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signphone.dart';

import 'authenticate/Sign/signemail.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        child:
            Center(
              child:
               Padding(
                 padding: const EdgeInsets.only(top : 100, left: 35),
                 child: Column(
                   children: <Widget>[
                 Text("Se Connecter : " , style: TextStyle(color: Colors.black, fontSize: 20)),
                 SizedBox(height : 10),
                 Row(
                   children : <Widget>[
                  RaisedButton.icon(
                    icon: Icon(Icons.phone),
                    color: Colors.lightGreen[400],
                    label: Text("via phone"), onPressed: ()  {
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Signphone()),);}),
                  SizedBox(width: 10.0),
                  RaisedButton.icon(
                   icon: Icon(Icons.email),
                   color: Colors.lightGreen[400],
                   label: Text("via email"), onPressed: ()  {
                   Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => Sign()),);
            },
            )
                   ],
                 ), 
                 SizedBox(height : 30.0 ),
                 Text("S'inscrire : ",style: TextStyle(color: Colors.black, fontSize: 20)),
                 SizedBox(height : 10.0 ),
                 Row(
                   children : <Widget>[
                  RaisedButton.icon(
                    icon: Icon(Icons.phone),
                    color: Colors.lightGreen[400],
                    label: Text("via phone"), onPressed: ()  {
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Phone()));}),
                  SizedBox(width: 10.0),
                  RaisedButton.icon(
                   icon: Icon(Icons.email),
                   color: Colors.lightGreen[400],
                   label: Text("via email"), onPressed: ()  {
                   Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => Register()));
            },
            )
                   ],
                 ), 


          ],
        ),
               ),
      ),
      ),
    );
  }
}

