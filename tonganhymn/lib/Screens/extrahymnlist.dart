// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import 'hivausu.dart';

class ExtraHymnList extends StatefulWidget {
  @override
  _ExtraHymnList createState() => _ExtraHymnList();
}

class _ExtraHymnList extends State<ExtraHymnList> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    List? mydata;
    return Container(
      child: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('load_json/papimoemali.json'),
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
                                  index: index,
                                  file: "papimoemali",
                                  fontname: "Amiri",
                                  fontsize: 20)));
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
              itemCount: mydata == null ? 0 : mydata?.length,
            );
          },
        ),
      ),
    );
  }
}
