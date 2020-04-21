import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/register.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/sign.dart';
import 'home/page2.dart';
import 'authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController utilisateur_controller = TextEditingController();
    TextEditingController mot_de_passe = TextEditingController();
    bool passwordhiden = true;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Car control'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.only(top: 30),
                  child:
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: Image.asset("assets/logo.png",
                            fit: BoxFit.fill)),
                  )
              ),
            ),

            RaisedButton(
              color: Colors.lightGreen[400],
              child: Text("Se connecter"), onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Sign()),);
  },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.lightGreen[400],
              child: Text("S'inscrire "), onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Register()),);
            },
            ),
          ],
        ),
      ),
    );
  }
}

