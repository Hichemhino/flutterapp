import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() =>
    runApp(
      MaterialApp(home: Suite()),
    );

class Suite extends StatefulWidget {
  @override
  _SuiteState createState() => _SuiteState();
}

class _SuiteState extends State<Suite> {
  int etat_led;
  bool open = true;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final database_LED = FirebaseDatabase.instance.reference();
    Map etat_du_system = Map();
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),

        backgroundColor: Colors.green[900],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.power_settings_new,color: Colors.white,),
            label: Text('Logout', style : TextStyle(color: Colors.white,letterSpacing: 1.0 ),),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
        ],
      ),
      body:
          Column(
            children: <Widget>[
              /* light */
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("Light ON"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_parking_light": 2,
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("Light OFF"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_parking_light": -1,
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 32),
                      child:
                      StreamBuilder(
                        stream: database_LED.onValue,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(
                              "wait!",
                            );
                          }
                          else if (snapshot.hasError) {
                            return Text(
                              snapshot.error,
                            );
                          }
                          else if (snapshot.hasData) {
                            etat_du_system = snapshot.data.snapshot.value;
                            if (etat_du_system["state_parking_light"] == 1)
                              return Icon(Icons.lightbulb_outline , color : Colors.deepOrange);
                            else if (etat_du_system["state_parking_light"] == 0)
                              return Icon(Icons.lightbulb_outline);
                            else
                              return CircularProgressIndicator();
                          }
                          else {
                          return Text('null data!');
                          }
                        },
                      )
                  ),

                ],
              ),

              /* Climat */
              Row(
                children : <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: RaisedButton(
                    child: Text("Clima ON"),
                    onPressed: () async {
                      await _database.reference().update({
                        "state_clima": 2,
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: RaisedButton(
                    child: Text("clima OFF"),
                    onPressed: () async {
                      await _database.reference().update({
                        "state_clima": -1,
                      });
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, left: 32),
                    child:
                    StreamBuilder(
                      stream: database_LED.onValue,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(
                            "wait!",
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text(
                            snapshot.error,
                          );
                        }
                        else if (snapshot.hasData) {
                          etat_du_system = snapshot.data.snapshot.value;
                          if (etat_du_system["state_clima"] == 1)
                            return Icon(Icons.ac_unit, color: Colors.blue);
                          else if (etat_du_system["state_clima"] == 0)
                            return Icon(Icons.ac_unit , color : Colors.red);
                          else
                            return CircularProgressIndicator();
                        }
                        else {
                          return Text('null data!');
                        }
                      },
                    )
                ),
                  ]
              ),

              /* Window */
              Row(children: <Widget>[
                Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: RaisedButton(
                  child: Text("Window-up"),
                  onPressed: () async {
                    await _database.reference().update({
                      "state_window": 2,
                    });
                  },
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: RaisedButton(
                    child: Text("Window-Down"),
                    onPressed: () async {
                      await _database.reference().update({
                        "state_window": -1,
                      });
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, left: 32),
                    child:
                    StreamBuilder(
                      stream: database_LED.onValue,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(
                            "wait!",
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text(
                            snapshot.error,
                          );
                        }
                        else if (snapshot.hasData) {
                          etat_du_system = snapshot.data.snapshot.value;
                          if (etat_du_system["state_window"] == 1)
                            return Icon(Icons.arrow_upward);
                          else if (etat_du_system["state_window"] == 0)
                            return Icon(Icons.arrow_downward);
                          else
                            return CircularProgressIndicator();
                        }
                        else {
                          return Text('null data!');
                        }
                      },
                    )
                ),
              ],
              ),

              /* Door lock */
              Row(
                children: <Widget>[
                  Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: RaisedButton(
                  child: Text("Door lock"),
                  onPressed: () async {
                    await _database.reference().update({
                      "state_door_lock": 2,
                    });
                  },
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("door open"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_door_lock": -1,
                        });
                      },
                    ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 32),
                    child:
                    StreamBuilder(
                      stream: database_LED.onValue,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(
                            "wait!",
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text(
                            snapshot.error,
                          );
                        }
                        else if (snapshot.hasData) {
                          etat_du_system = snapshot.data.snapshot.value;
                          if (etat_du_system["state_door_lock"] == 1)
                            return Icon(Icons.lock_outline);
                          else if (etat_du_system["state_door_lock"] == 0)
                            return Icon(Icons.lock_open);
                          else
                            return CircularProgressIndicator();
                        }
                        else {
                          return Text('null data!');
                        }
                      },
                    )
                ),]
                ,
              ),

              /*siren */
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("Siren On"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_alarme": 2,
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("Siren off"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_alarme": -1,
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 32),
                      child:
                      StreamBuilder(
                        stream: database_LED.onValue,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(
                              "wait!",
                            );
                          }
                          else if (snapshot.hasError) {
                            return Text(
                              snapshot.error,
                            );
                          }
                          else if (snapshot.hasData) {
                            etat_du_system = snapshot.data.snapshot.value;
                            if (etat_du_system["state_alarme"] == 1)
                              return Icon(Icons.alarm_on);
                            else if (etat_du_system["state_alarme"] == 0)
                              return Icon(Icons.alarm_off);
                            else
                              return CircularProgressIndicator();
                          }
                          else {
                            return Text('null data!');
                          }
                        },
                      )
                  ),
                ],
              ),

              /*car starter */
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("starter On"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_car_starter": 2,
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: RaisedButton(
                      child: Text("starter off"),
                      onPressed: () async {
                        await _database.reference().update({
                          "state_car_starter": -1,
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 32),
                      child:
                      StreamBuilder(
                        stream: database_LED.onValue,
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(
                              "wait!",
                            );
                          }
                          else if (snapshot.hasError) {
                            return Text(
                              snapshot.error,
                            );
                          }
                          else if (snapshot.hasData) {
                            etat_du_system = snapshot.data.snapshot.value;
                            if (etat_du_system["state_car_starter"] == 1)
                              return Icon(Icons.assignment_turned_in);
                            else if (etat_du_system["state_car_starter"] == 0)
                              return Icon(Icons.assignment_late);
                            else
                              return CircularProgressIndicator();
                          }
                          else {
                            return Text('null data!');
                          }
                        },
                      )
                  ),
                ],
              ),

            ],
          ),
    );
  }
}
