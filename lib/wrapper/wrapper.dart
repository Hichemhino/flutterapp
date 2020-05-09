import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registeremail.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registerphone.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Car control'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child:
            Center(
              child:
               Column(
                 children: <Widget>[
              RaisedButton.icon(
              icon: Icon(Icons.phone),
              color: Colors.lightGreen[400],
              label: Text("via phone"), onPressed: ()  {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Phone()),);}),
              SizedBox(height: 10.0),
              RaisedButton.icon(
              icon: Icon(Icons.email),
              color: Colors.lightGreen[400],
              label: Text("via email"), onPressed: ()  {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Register()),);
            },
            )
          ],
        ),
      ),
      ),
    );
  }
}

