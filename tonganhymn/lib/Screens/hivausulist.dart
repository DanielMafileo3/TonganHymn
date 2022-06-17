// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tonganhymn/Screens/hivausu.dart';

import 'hivausu.dart';

class HivaUsuList extends StatefulWidget {
  @override
  _HivaUsuList createState() => _HivaUsuList();
}

class _HivaUsuList extends State<HivaUsuList> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    List? mydata;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orange[900],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'NGAAHI HIVA USU',
          style: TextStyle(fontFamily: 'Amiri', color: Colors.white),
        ),
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ClipOval(
              child: Image.asset(
                'assets/images/sttlogowhiteandred.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // onTap: () async {
          // await Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => UserProfile()));
          // },
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('load_json/hivausu.json'),
            builder: (context, snapshot) {
              //Decode Json
              try {
                mydata = json.decode(snapshot.data.toString());
              } catch (err) {
                print(err);
              }

              return ListView.builder(
                itemBuilder: (context, int index) {
                  count = index + 1;
                  //print(mydata[index]['title']);
                  return Card(
                    child: InkWell(
                      splashColor: Colors.orange[900],
                      onTap: () {
                        //print("HymnList build index: $index");
                        //setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HivaUsu(
                                      file: "hivausu",
                                      fontname: "Comfortaa",
                                      fontsize: 17.0,
                                      index: index,
                                    )));
                        //});
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              mydata![index]['title'],
                              style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w400,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w400
                                  //fontFamily: 'Amiri'
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: mydata == null ? 0 : mydata!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
