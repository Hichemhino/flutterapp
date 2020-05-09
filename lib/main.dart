import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registeremail.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/registerphone.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signemail.dart';
import 'package:flutterappcarsecur/wrapper/authenticate/Sign/signphone.dart';
import 'package:flutterappcarsecur/wrapper/home/page2.dart';
import 'package:flutterappcarsecur/wrapper/load/load.dart';

Future<String> synchronisation() async{
  try {
    return((await FirebaseAuth.instance.currentUser()).uid);
  } catch (e) {
    print(e.toString());
    return(null);
  }
 }

void main() => runApp(MaterialApp(home: Home()),);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  
  @override

  Widget build(BuildContext context) {
   return(
   FutureBuilder(
     future: synchronisation(),
     builder:(context ,snapshot) {
          if(snapshot.hasData){
              return Suite(num: snapshot.data);
            }
          else {
            return Phone();
          }
     }
     )
     );
}  
}