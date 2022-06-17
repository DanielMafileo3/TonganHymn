// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tonganhymn/Screens/hivausulist.dart';
import 'package:tonganhymn/Screens/homepage.dart';
import 'package:tonganhymn/Screens/hymnlist.dart';

class StarterPage extends StatefulWidget {
  @override
  _StarterPage createState() => _StarterPage();
}

class _StarterPage extends State<StarterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Free_Church_of_Tonga.jpg'),
                  fit: BoxFit.cover),
            ),

            // color: Colors.white,
          ),
          Opacity(
            opacity: 0.9,
            child: Container(
                color: Colors.orange[900],
                padding: EdgeInsets.all(20),
                child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/sttlogowhiteandred.png'),
                            Container(
                              padding: EdgeInsets.all(0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Siasi 'O Tonga Tau'ataina",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white70),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Hymn App",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "UTOL TECH",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 150),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange[900],
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.white)),
                              ),

                              //color
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Text(
                                    "HIMI",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            height: 60,
                            width: 300,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: StadiumBorder(),
                              splashColor: Colors.orange[900],
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Text(
                                    "HIVA USU",
                                    style: TextStyle(color: Colors.orange[900]),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HivaUsuList()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ])),
          )
        ],
      ),
    );
  }
}
