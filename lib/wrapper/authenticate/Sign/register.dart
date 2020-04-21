import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    final _formKey = GlobalKey<FormState>();
    String password1,password2, email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text("Register "),
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
          ),
          SizedBox(height: 10),*/
          Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                    validator : (value) => value.isEmpty ? 'information no valide' : null  ,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    // controller: utilisateur_controller,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (val) => val.length <= 6 ? 'mot de passe ' : null,
                    onChanged : (val) {
                      setState (() => password1 = val);
                    },
                    //controller: mot_de_passe,
                    obscureText:true,
                    decoration: InputDecoration(hintText: "mot de passe"),
                  ),
                  RaisedButton(
                    color: Colors.lightGreen[400],
                    child: Text("Enregistrer"), onPressed: () async {
                    if(_formKey.currentState.validate()){
                      print(email);
                      print(password1);
                    }
                  },
                  ),
                ]
            ),
          ),

        ],
      ),

    );
  }
}