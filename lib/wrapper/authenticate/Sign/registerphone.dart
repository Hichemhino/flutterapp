
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/auth.dart';
import 'package:flutterappcarsecur/services/password_for_phone.dart';
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
  //TextEditingController _password = TextEditingController();

  final _phoneRegex = RegExp(r"^(0|\+213)(5|6|7)[0-9]{8}$");
  //final _chassiRegex = RegExp(r"^[0-9.a-zA-Z]+");
  //final _caractRegex = RegExp(r"[!#$%&:,§'*+-/=?^_`{|}~]");

  final _formKey = GlobalKey<FormState>();

  final Services _auth = Services();
  //final FirebaseDatabase _database = FirebaseDatabase.instance; 
  bool passwordhiden = true;
  bool loading = true;
  String erreur = '';
  String text = '';
  String verificationid,sms;
  String user ='';

  @override
  Widget build(BuildContext context) {
    
        return (!loading) ? Load() :  Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: RichText(
                text: TextSpan(
                    children: [
                        TextSpan(text: "Inscription ",style: TextStyle( fontSize: 20 )),
                        WidgetSpan(child: Icon(Icons.phone, size: 20),),
                      ],
                ),
              ),
              backgroundColor: Colors.green[400], 
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top :90.0, left: 8, right: 8),
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
                          await _auth.registerwithphone(_numerodephone.text,verificationid,sms,user)
                           .then((valeur) async{
                             //if (user != ''){
                               setState(() {
                                 loading = true;
                               });
                               print("user : " + user);
                               Navigator.of(context).pushReplacement(
                                 MaterialPageRoute(builder: (context) => Passwords(numphone : _numerodephone.text)));
                             //}
                            // else{
                              // new Text('reste la');
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
      ),
    );
  }
}

