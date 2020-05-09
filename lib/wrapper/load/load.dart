import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: <Widget>[ 
                   SpinKitFadingCircle(
                         color: Colors.green,
                         size: 100.0,
                      ),
                  SizedBox(height : 10.0),
                  Text('veuillez patientez quelque instant...', style: TextStyle(color: Colors.green, fontSize: 13,decoration: TextDecoration.none)),
                ],
              ),
            ),
          ),
    );
  }
}