import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signemail.dart';
import 'package:flutterappcarsecur/wrapper/home/page2.dart';

class Signphone extends StatefulWidget {
  @override
  _SignphoneState createState() => _SignphoneState();
  final String sms;
  Signphone({this.sms});
}

class _SignphoneState extends State<Signphone> {
  TextEditingController _numerodephone = TextEditingController();
  TextEditingController _password = TextEditingController();

  final _phoneRegex = RegExp(r"^(0|\+213)(5|6|7)[0-9]{8}$");
  final _formKey = GlobalKey<FormState>();
  final Services _auth = Services();
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  bool passwordhiden = true;
  String message = '';
  
  bool loading = true;
  String erreur = '';
  String numchassi,numphone;
  String text = '';
  @override
  Widget build(BuildContext context) {
    if (widget.sms != null){
    setState(() {
       message = widget.sms;
    });
  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Sign in with phone"),
          actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.mail,color: Colors.white,),
            label: Text('Sign In', style : TextStyle(color: Colors.white,letterSpacing: 1.0 ),),
            onPressed: () async{
               dynamic result = _auth.singOutAccount();
               if(result != null){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Sign()),);
               }
            },
          ),
          ],
      ),
      body: Center(
        child : Form(
          key: _formKey,
          child: Column(
            children : <Widget>[
                       // numero de phone
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
                       ),
                       ),
                    ),
                    SizedBox(height: 10),
                    // boutton
                    RaisedButton(
                      color: Colors.lightGreen[400],
                      child: Text("connexion"), onPressed: () async {
                        if(_formKey.currentState.validate()){
                         await (Connectivity().checkConnectivity()).then((connectivityResult) async{
                          if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                          setState(() {
                           loading = false;
                           erreur = '';
                          });  
                            await _auth.registerwithphone(_numerodephone.text , context).then((value) async{
                              DatabaseReference _ref = _database.reference();
                                  await  _ref.child("Userphone").child(_numerodephone.text
                                  ).once().then((DataSnapshot snapshot) async{
                                        numphone = await snapshot.value;
                                        
                                  }).then((onValue) async{
                                    if (numphone == _password.text) {
                                      await _ref.child("all_email").child(_numerodephone.text).once().then((DataSnapshot snapshot){
                                        numchassi = snapshot.value;
                                  });                       
                                    setState(() {
                                        loading = true;
                                        erreur = '';
                                    });
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Suite(num: numchassi)),);
                                       }  
                                       else{
                                          setState(() {
                                            loading = true;
                                            erreur = 'mot de passe ou numéro de telephone incorrecte';
                                      }); 
                          }     
                                  });


                            });
                         
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
                    Text(erreur,style: TextStyle(color:  Colors.red)),
                    Text(message, style: TextStyle(color: Colors.green))
            ]
          ) ,
          ),
      ),
    );
  }
}