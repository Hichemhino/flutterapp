import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/services/password_for_phone.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/motdepasse.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signphone.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  
  bool user_1 = false;
  
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
    Future registerwithphone(String phone, String verificationid,String sms,String user) async{
      TextEditingController code = TextEditingController();
     
     /*final PhoneCodeAutoRetrievalTimeout autoretrieve = (String id){
       verificationid = id;
     };*/

     /*final PhoneCodeSent codesent = (String verification,[int renvoyerlecode]){
       verificationid = verification;
       BuildContext context;
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
                             user = resultat.user.uid;
                             if (user != null){
                               Navigator.of(context).pop();
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Passwords(numphone: phone)));
                             }
                             else{
                               Navigator.of(context).pop();
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Signphone(sms: 'code de verification incorrecte')));
                             }

                           });
                            }),
                    ],
                );
              }
            );

     };*/

     /*final PhoneVerificationCompleted verificationAvecSucce = (AuthCredential credential) async{
       await _auth.signInWithCredential(credential).then((AuthResult result){
          user = result.user.uid;
       });
     };*/

     /*final PhoneVerificationFailed verificationAvecechec = (AuthException exception){
       print("==> ${exception.message}");
     };*/
        _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 120), 
      verificationCompleted: (AuthCredential credential) async{
       await _auth.signInWithCredential(credential).then((AuthResult result){
          user = result.user.uid;
       });
      },
      verificationFailed: (AuthException exception){
       print("==> ${exception.message}");
     },
      codeSent: (String verification,[int renvoyerlecode]){
       verificationid = verification;
       BuildContext context;
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
                             user = resultat.user.uid;
                             if (user != null){
                               Navigator.of(context).pop();
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Passwords(numphone: phone)));
                             }
                             else{
                               Navigator.of(context).pop();
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Signphone(sms: 'code de verification incorrecte')));
                             }

                           });
                            }),
                    ],
                );
              }
            );
     },
      codeAutoRetrievalTimeout: null,
      );
      /*codeAutoRetrievalTimeout: (String id){
       verificationid = id;
      }*/

}



/*
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
                             user = resultat.user;
                             if (user != null){
                               Navigator.of(context).pop();
                               Navigator.of(context).pushReplacementNamed('/');
                             }
                             else{
                               Navigator.of(context).pop();
                             }

                           });
                            }),
                    ],
                );
              }
            );
*/
  } 