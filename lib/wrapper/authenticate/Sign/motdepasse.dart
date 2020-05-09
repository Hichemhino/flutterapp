import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signemail.dart';
import 'package:flutterappcarsecur/wrapper/load/load.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
 // int screen_state;
 // Sign({this.screen_state});
}

class _PasswordState extends State<Password> {
    String message = '';
    final _formkey = GlobalKey<FormState>();
    final Services _auth = Services();
    TextEditingController _email = TextEditingController();
    final _emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
    bool loading = true;
    @override
  Widget build(BuildContext context) {
    return  !loading ?  Load() : Scaffold(
      appBar: AppBar(
        title: Text('Changer le mot de passe'),
        centerTitle: true,
        backgroundColor: Colors.green[900],     
         ),
       body: Center(
              child:
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(hintText :"votre email"),
                        controller: _email,
                        validator: (val) => val.contains(_emailRegex) ? null : 'addresse email non valide',
                     ),
                      RaisedButton(
                        child: Text('envoyer'),
                        color: Colors.green[400],
                        onPressed:() async {
                          if(_formkey.currentState.validate()){
                            await (Connectivity().checkConnectivity()).then((connectivityResult) async{
                                if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
                                  setState(() {
                                 loading = false;
                                 message = '';
                                });
                                await _auth.resetpassword(_email.text).then((onValue){
                                  loading = true;
                                  Navigator.of(context).pushReplacement(
                                     MaterialPageRoute(builder: (context) => Sign(num: "veuillez verifier votre boite mail")));
                            });
                                }
                                else{
                                  setState(() {
                                   message = 'pas de connexion internet';
                                  });
                                }
                            });                         
                           }
                          }  
                      ),
                      Text(message,style: TextStyle(color: Colors.red),),
                    ]    
                  )
                    
                )
                )
           
         
       );
  }
}


