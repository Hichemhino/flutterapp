import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  
  FirebaseUser user_1;
  
  // sign in with anny
  Future signInAn() async {
    try{
    AuthResult result =  await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return (user.uid);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign out
  // ignore: non_constant_identifier_names
  Future singOutAccount() async{
    try{
     return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // Register with email and password
  Future registerwithemailandpassword(String email,String password) async {
    try{
      AuthResult result  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return(user.uid);
    }catch(e){
      print(e.toString());
      return null;
    }
    
  }
  // Sign with email and password
  Future signInwithEmailandPassword(String email, String password) async {
   try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return(user.uid);
   }catch(e){
     print(e.toString());
   }
  }

  // reset the password with email
  Future resetpassword(String email) async {
    try{
      return (await _auth.sendPasswordResetEmail(email: email));
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // Sign with phone
  Future<String> registerwithphone(String phone, BuildContext context) async{
    TextEditingController code = TextEditingController();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone, 
        timeout: Duration(minutes: 2),
        ///////////////////////////////
      verificationCompleted: (AuthCredential credential) async {
        try {
         Navigator.of(context).pop();
          await  _auth.signInWithCredential(credential).then((AuthResult result){
            user_1 = result.user;
          });
          if (user_1 != null)
            return(user_1.uid);
          else
            return(null);
        } catch (e){
          print(e.toString());
          return null;
        }
    },
      codeSent: (String verificationid,[int forceresendingtoken]){
        try {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(
                  backgroundColor: Colors.green,
                  content: 
                    TextField(
                        decoration: InputDecoration(hintText:"veuillez saisir votre code"),
                        maxLength: 6,
                        controller: code,
                      ),
                    actions: <Widget>[
                      RaisedButton(
                        child:Text("envoyer"),
                        onPressed: () async{
                           AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationid, smsCode: code.text);
                           await _auth.signInWithCredential(credential).then((AuthResult resultat){
                             user_1 = resultat.user;
                           });
                            }),
                    ],
                );
              }
            );
          if (user_1 != null)
            return(user_1.uid);
          else
            return(null);   
        } catch (e) {
          print(e.toString());
          return null;
        }

        },
      codeAutoRetrievalTimeout: null, 
      verificationFailed: (AuthException error) {
           print(error.code);
           user_1 = null;
           return(user_1);
         }, 
        );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign with phone

  //




}