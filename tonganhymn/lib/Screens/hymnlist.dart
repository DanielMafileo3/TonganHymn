import 'dart:convert';

import 'package:flutter/material.dart';

import 'extrahymnlist.dart';
import 'hymn.dart';

class HymnList extends StatefulWidget {
  @override
  _HymnList createState() => _HymnList();
}

class _HymnList extends State<HymnList> {
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: PageController(initialPage: 0),
        children: <Widget>[Himi(), ExtraHymnList()]);
  }
}

class Himi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    List? mydata;

    return Container(
      //color: Colors.redAccent,
      child: Center(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('load_json/hymns.json'),
          builder: (context, snapshot) {
            //Decode Json
            try {
              mydata = json.decode(snapshot.data.toString());
              //print(mydata);
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
                              builder: (context) =>
                                  Hymn(index, mydata![index]['title'])));
                      //});
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            count.toString() + ". " + mydata![index]['title'],
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.w400,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              //color: Colors.white
                              //fontFamily: 'Amiri'
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
                            child: Text(
                              mydata![index]['mita'],
                              style: TextStyle(fontFamily: 'Amiri'),
                            ),
                          )
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
    );
  }
}
