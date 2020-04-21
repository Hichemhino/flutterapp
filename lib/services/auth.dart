import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappcarsecur/user/user.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromfirebase(FirebaseUser user){
    return user != null ? User(uid : user.uid) : null;
  }
  
  // sign in with anny
  Future signInAn() async {
    try{
    AuthResult result =  await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromfirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  // sign out
  // ignore: non_constant_identifier_names
  Future SingOutAccount() async{
    try{
     return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromfirebase);
  }




}