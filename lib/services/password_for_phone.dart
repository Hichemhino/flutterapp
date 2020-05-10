import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

class Passwords extends StatefulWidget {
  @override
  _PasswordsState createState() => _PasswordsState();
  final String numphone;
  Passwords({this.numphone});
}

class _PasswordsState extends State<Passwords> {
  String numphone;
  String erreur = '';
  final _formKey = GlobalKey<FormState>();
  bool passwordhiden = true;
  bool loading = true;
  TextEditingController _password = TextEditingController();
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  String text = '';

  @override
  Widget build(BuildContext context) { 
    if(widget.numphone != null){
      setState(() {
        numphone = widget.numphone;
      });
    }
    return    FutureBuilder(
     future: synchronisation(),
     builder:(context ,AsyncSnapshot<String> snapshot) {
       switch (snapshot.connectionState) {
         case ConnectionState.waiting : return Load();
         default :          
          if(snapshot.hasData){
            if (!loading){
              return Load();
            } 
            else{
             Padding(
               padding: const EdgeInsets.only(top :90.0, left: 8, right: 8),
               child: Center(
                 child: new Form(
                  child: Column(
                    children : <Widget>[
                              // mot de passe
                               TextFormField(
                                validator: (val) => val.length >= 6 ? null : 'mot de passe non valide' ,
                                controller: _password,
                                obscureText: passwordhiden,
                                decoration: InputDecoration(hintText: "Veuillez introduire votre Mot de passe",
                                suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), 
                                 onPressed:()   {
                                   setState(() {
                                  passwordhiden = !passwordhiden;
                                  });
                                 }                      
                               ),
                               ),
                              ),
                          RaisedButton(
                            color: Colors.lightGreen[400],
                            child: Text("Suivant"), onPressed: () async {
                            if(_formKey.currentState.validate()){
                              await (Connectivity().checkConnectivity()).then((connectivityResult) async{
                                if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
                                 setState(() {
                                   loading = false;
                                   erreur = '';
                                });
                                await _database.reference().child(snapshot.data).set({
                                    "state_parking_light":-1,
                                    "state_window":-1,
                                    "state_parking_light":-1,
                                    "state_door_lock":-1,
                                    "state_clima":-1,
                                    "state_car_starter":-1,
                                    "state_alarme" : -1,
                                  }).then((value) async{
                                    await _database.reference().child("all_email").set({
                                      numphone: snapshot.data+"//"+_password.text,
                                    }).then((value) async{ 
                                        setState(() {
                                          loading = true;
                                          erreur = '';
                                          text = 'inscription réussite';
                                          }); 
                                    });
                                  });
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => Signphone()));
                                } // pas de touche
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
                    ]
                  )
            ),
               ),
             );
            }
           return Padding(
             padding: const EdgeInsets.only(top : 100),
             child: Center(child: (new Text(erreur, style: TextStyle(color: Colors.red)))),
           );
            }
          else {
            return Padding(
              padding: const EdgeInsets.only(top : 100),
              child: Center(
                child: (
                  new Text('', style : TextStyle(color:Colors.red))
                ),
              ),
            );
          }
       }
     }
     );
  }
}

/*
                             await _database.reference().set({
                                "state_parking_light":-1,
                                "state_window":-1,
                                "state_parking_light":-1,
                                "state_door_lock":-1,
                                "state_clima":-1,
                                "state_car_starter":-1,
                                "state_alarme" : -1,
                              }).then((value) async{
                                await _database.reference().child("all_email").set({
                                  _numerodephone.text : 5,
                                }).then((value) async{
                                  await _database.reference().child("Userphone").set({
                                    _numerodephone.text : _password.text,
                                  }).then((onValue){
                                    setState(() {
                                    loading = true;
                                      erreur = '';
                                      text = 'inscription réussite';
                                      }); 
                                  });
                                });
                              });
                            //}
                          });
 */