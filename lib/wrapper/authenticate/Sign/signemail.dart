import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/motdepasse.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signphone.dart';
import 'package:flutterappcarsecur/wrapper/home/page2.dart';
import 'package:flutterappcarsecur/wrapper/load/load.dart';
import 'package:flutterappcarsecur/wrapper/wrapper.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
 final String num;
 Sign({this.num});
}
class _SignState extends State<Sign> {
  final Services _auth = Services();
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
  final _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool loading = true;
  bool passwordhiden = true;
  String message = '';
  String erreur = '';
  String uid;
  @override
  Widget build(BuildContext context) {
    if (widget.num != null){
      setState(() {
        message = widget.num;
      });
    }
    if(loading){
      return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Text("Sign In with email"),
          actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.phone,color: Colors.white,),
            label: Text('Sing In', style : TextStyle(color: Colors.white,letterSpacing: 1.0 ),),
            onPressed: () async{
               dynamic result = _auth.singOutAccount();
               if(result != null){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Signphone()),);
               }
            },
          ),
          ],
        ),
        body: 
        SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Form(
                key: _formkey,
                child : Column(
                  children : <Widget>[
                    // email
                    TextFormField(
                      validator: (val) => val.contains(emailRegex) ? null : 'email non valide' ,
                      controller: _email,
                      decoration: InputDecoration(hintText: "Email"),
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
                    SizedBox(height: 10.0),
                    // boutton
                    RaisedButton(
                      color: Colors.lightGreen[400],
                      child: Text("connexion"), onPressed: () async {
                        if(_formkey.currentState.validate()){
                         await (Connectivity().checkConnectivity()).then((connectivityResult) async{
                          if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                          setState(() {
                           loading = false;
                           erreur = '';
                          });  
                         dynamic result = await _auth.signInwithEmailandPassword(_email.text,_password.text);
                         if(result != null){
                            DatabaseReference _ref = FirebaseDatabase.instance.reference().child("all_email").child(_email.text
                            .split(".")[0]);
                            await  _ref.once().then((DataSnapshot snapshot){
                                  uid = snapshot.value;
                            }).then((onValue){
                                setState(() {
                                  loading = true;
                                  erreur = '';
                              });
                              print("uid  = " + uid + "  result  = " + result);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Suite(num: uid)));
                            });
                         }
                          else{
                            setState(() {
                            loading = true;
                             erreur = 'mot de passe ou email incorrecte';
                          }); 
                          }
                         }
                        else{
                              setState(() {
                                erreur = 'pas de connexion internet';
                              });
                            }
                          });
                        }
                    },
                    ),
                    Text(erreur,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 5.0),
                    Text(message , style: TextStyle(color : Colors.red)),
                    SizedBox(height: 10.0),
                    // mot de passe oublié
                   InkWell(
                   child: Text("mot de passe oublié ?" , style: TextStyle(color: Colors.grey[600],decoration: TextDecoration.underline),),
                   onTap:() {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Password()),);
                   }
                  ),
                    SizedBox(height: 10.0),
                    // inscription
                    InkWell(
                      child: Text("Cliquez ici pour S'inscrire " , style: TextStyle(color: Colors.grey[600],decoration: TextDecoration.underline),),
                      onTap:()  {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Wrapper()),);
                        },
                    ),
                    
                  ]

                ),
              ),
            ],
          ),
        ),

    );
     }
    else{
      return Load();
    }
     
  }
  }




