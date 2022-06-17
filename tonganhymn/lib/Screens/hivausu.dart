// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HivaUsu extends StatefulWidget {
  final int index;
  final String file;
  final String fontname;
  final double fontsize;

  HivaUsu(
      {required this.index,
      required this.file,
      required this.fontname,
      required this.fontsize});

  @override
  _HivaUsu createState() => _HivaUsu();
}

class _HivaUsu extends State<HivaUsu> {
  List<String> titles = [];
  List? data;
  int count = 0;

  static var controller = PageController(initialPage: 1);

  var pageview = PageView(
    controller: controller,
    children: <Widget>[],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.orange[900],
          // iconTheme: IconThemeData(color: Colors.white),
          ),
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("load_json/${widget.file}.json"),
          builder: (context, snapshot) {
            var mydata = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      //Hymn Number and Mita
                      Container(
                        padding: EdgeInsets.all(20),
                        // color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Section of the hymn
                            Text(
                              mydata[widget.index]['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  //color: Colors.black,
                                  //fontWeight: FontWeight.w600,
                                  fontFamily: 'Amiri'),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            Divider(),
                          ],
                        ),
                      ),

                      //The Hymn Lyrics
                      Container(
                        //color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              //color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  SelectableText(
                                    mydata[widget.index]['body'],
                                    style: TextStyle(
                                        fontSize: widget.fontsize,
                                        wordSpacing: 4,
                                        height: 1.7,
                                        //color: Colors.black54,
                                        fontFamily: widget.fontname,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    onTap: () {},
                                  ),
                                  Divider(),
                                  Divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: mydata == null ? 0 : 1,
            );
          },
        ),
      ),
    );
  }
}
