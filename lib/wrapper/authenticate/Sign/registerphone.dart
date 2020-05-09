import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signphone.dart';
import 'package:flutterappcarsecur/wrapper/load/load.dart';

Future<String> synchronisation() async{
  try {
    return((await FirebaseAuth.instance.currentUser()).uid);
  } catch (e) {
    print(e.toString());
    return(null);
  }
 }

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController _numerodephone = TextEditingController();
  TextEditingController _numeroduchassi = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _phoneRegex = RegExp(r"^(0|\+213)(5|6|7)[0-9]{8}$");
  final _chassiRegex = RegExp(r"^[0-9.a-zA-Z]+");
  final _caractRegex = RegExp(r"[!#$%&:,§'*+-/=?^_`{|}~]");

  final _formKey = GlobalKey<FormState>();

  final Services _auth = Services();
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  bool passwordhiden = true;
  bool loading = true;
  String erreur = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    
        return (!loading) ? Load() :  Scaffold(
          appBar: AppBar(
            title: Text("Register with phone"),
              backgroundColor: Colors.green[900],
          ),
          body: SingleChildScrollView(
            child: Form(
               key: _formKey,
                child: Column(
                  children : <Widget>[
                    // numéro de telephone
                        TextFormField(
                          maxLength: 13,
                          decoration: InputDecoration(hintText: "Votre numéro de téléphone"),
                          controller: _numerodephone,
                          validator: (val) => (_phoneRegex.hasMatch(val)) ? null : "numéro de telephone incorrecte",
                        ),
                        SizedBox(height: 10),
                    // mot de passe
                    TextFormField(
                        validator: (val) => val.length >= 6 ? null : 'mot de passe non valide' ,
                        controller: _password,
                        obscureText: passwordhiden,
                        decoration: InputDecoration(hintText: "mot de passe",
                         suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), 
                      onPressed:()   {
                        setState(() {
                          passwordhiden = !passwordhiden;
                        });
                       }                      
                      ),),
                    ),
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
                        print(_numerodephone.text);  
                        await _auth.registerwithphone(_numerodephone.text , context)
                         .then((value) async{
                           FutureBuilder(future: synchronisation(),
                           builder: (context , snapshot) {
                             if(snapshot.hasData){
                               value = snapshot.data;
                               return(this.widget);
                             }
                             else{
                               return null;
                             }
                           }
                           );
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
                                _numerodephone.text : value,
                              }).then((value) async{
                                await _database.reference().child("Userphone").set({
                                  _numerodephone.text : _password.text,
                                }).then((onValue){
                                  setState(() {
                                  loading = true;
                                    erreur = '';
                                    text = 'inscription réussite';
                                    }); 
                               Navigator.of(context).pushReplacement(
                               MaterialPageRoute(builder: (context) => Signphone(sms: text)));
                                });
                              });
                            });
                          //}
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
      ),
    );
  }
}

