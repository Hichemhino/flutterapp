import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/register.dart';
import 'package:flutterappcarsecur/wrapper/home/page2.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
 // int screen_state;
 // Sign({this.screen_state});
}

class _SignState extends State<Sign> {
 // final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController utilisateur_controller = TextEditingController();
  TextEditingController mot_de_passe = TextEditingController();
  String password,email;
  bool passwordhiden = true;
  final Services _auth = Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text("Sign In"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
           /* Center(
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
            ),*/
            SizedBox(height: 10),
            Form(
              child : Column(
                children : <Widget>[
                  TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                      //if (email.contains("@") && (email.contains(".com") || email.contains(".fr")))
                    },
                    controller: utilisateur_controller,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      onChanged : (val) {
                        setState(() => password = val);
                      },
                      controller: mot_de_passe,
                      obscureText: passwordhiden,
                      decoration: InputDecoration(hintText: "mot de passe"),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: Colors.lightGreen[400],
                    child: Text("connexion"), onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Suite()),);
                  },
                  ),
               SizedBox(height: 5.0),
               InkWell(
                 child: Text("mot de passe oublié ?" , style: TextStyle(color: Colors.grey[600],decoration: TextDecoration.underline),),
                 onTap:() => print("etape pour changer le mot de passe"),
               ),
               SizedBox(height: 10.0),
               InkWell(
                    child: Text("Cliquez ici pour S'inscrire " , style: TextStyle(color: Colors.grey[600],decoration: TextDecoration.underline),),
                    onTap:()  {print("S'inscrire");},
                  ),

                ]
              ),
            ),

          ],
        ),

    );
  }
}
