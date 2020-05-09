import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signemail.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutterappcarsecur/wrapper/load/load.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    // RegExp
    final _emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
    final _chassiRegex = RegExp(r"^[0-9.a-zA-Z]+");
    final _caractRegex = RegExp(r"[!#$%&:,§'*+-/=?^_`{|}~]");
    //// controlle
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _numeroduchassi = TextEditingController();
    // firebase
    final FirebaseDatabase _database = FirebaseDatabase.instance; 
    
    // autre variable
    final Services _auth = Services();
    final _formKey = GlobalKey<FormState>();
    bool loading = true;
    String erreur = '';
    bool passwordhide = true;
  @override
  Widget build(BuildContext context) {
    return  !loading ?  Load() :    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text("Register "),
        centerTitle: true,
      ),
      body: 
      SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    // email
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      controller: _email,
                      validator : (value) => _emailRegex.hasMatch(value) ?  null : "email no valide" ,
                    ),
                    SizedBox(height: 10),
                    // mot de passe
                    TextFormField(
                      decoration: InputDecoration(hintText: "mot de passe",
                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), 
                      onPressed:()   {
                        setState(() {
                          passwordhide = !passwordhide;
                        });
                       }                      
                      ),
                      
                      ),
                      controller: _password,
                      obscureText:passwordhide,
                      validator: (val) => val.length <= 6 ? 'mot de passe ' : null,
                    ),
                    SizedBox(height: 10),
                    // numero de chassi
                   /* TextFormField(
                      validator: (val) => (val.contains(_chassiRegex) && !val.contains(_caractRegex)) ? null : "erreur dans le numero de chassis",
                      decoration: InputDecoration(hintText: "numero de chassis de votre vehicule"),
                      controller: _numeroduchassi,
                    ),*/
                    SizedBox(height: 10),
                   // boutton
                    RaisedButton(
                      color: Colors.lightGreen[400],
                      child: Text("Enregistrer"), onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await (Connectivity().checkConnectivity()).then((connectivityResult) async{
                          if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
                           setState(() {
                             loading = false;
                             erreur = '';
                          });
                        await _auth.registerwithemailandpassword(_email.text,_password.text)
                         .then((value) async{
                          if(value != null){
                            await _database.reference().child(value).set({
                              "state_parking_light":-1,
                              "state_window":-1,
                              "state_parking_light":-1,
                              "state_door_lock":-1,
                              "state_clima":-1,
                              "state_car_starter":-1,
                              "state_alarme" : -1,
                            }).then((valeur) async{
                              await _database.reference().child("all_email").set({
                                _email.text.split(".")[0] : value,
                              }).then((value){
                              setState(() {
                               loading = true;
                               erreur = '';
                              });
                              
                              Navigator.of(context).pushReplacement(
                               MaterialPageRoute(builder: (context) => Sign()));
                              });
                            });
                          }
                        }); 
                          }
                          else{
                              setState(() {
                                erreur = 'pas de connexion internet';
                              });
                          }
                        }
                        );
                       }
                      }
                    ),
                    Text(erreur, style:  TextStyle(color: Colors.red)),
                  ]
              ),
            ),

          ],
        ),
      ),

    );
  }
}




                       /* */