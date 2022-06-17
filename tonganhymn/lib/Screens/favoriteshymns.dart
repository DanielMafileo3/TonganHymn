// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:tonganhymn/Models/database.dart';

//TaskModel currentTask;
var mydata;
int? currentPage;

//final TodoHelper _todoHelper = TodoHelper();
bool? hasChangedPages;

class FavoriteHymn extends StatefulWidget {
  List<TaskModel> l;
  TaskModel? currentTask;
  final int indexNUm;

  FavoriteHymn({required this.indexNUm, required this.l});

  @override
  _FavoriteHymn createState() => _FavoriteHymn();
}

class _FavoriteHymn extends State<FavoriteHymn> {
  // int hymnIndex;
  List<Widget> hymns = [];
  //static int num;
  // List<String> titles = [];
  // List data;
  int count = 0;

  // String section;
  // String number;
  // String mita;
  // String lyrics;

  //int num = 0;

  //List<TaskModel> favHymn = [];
  List<int> favNum = [];

  // _FavoriteHymn(int i, List<TaskModel> lists) {
  //   num = i;

  //   favHymn = lists;

  //   getHymns();
  //   print(i);
  // }

  List<Widget> getHymns() {
    for (TaskModel i in widget.l) {
      favNum.add(int.parse(i.number) - 1);
    }

    for (int i = 0; i < favNum.length; i++) {
      hymns.add(
        HymnLyrics(
          hymnIndex: favNum[i],
        ),
      );
    }
    return hymns;
  }

  @override
  Widget build(BuildContext context) {
    getHymns();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Hymns',
            style: TextStyle(
                fontFamily: 'Nanum Gothic', color: Colors.white, fontSize: 15),
          ),
          // backgroundColor: Colors.orange[900],
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: PageView(
            controller:
                PageController(initialPage: favNum.indexOf(widget.indexNUm)),
            children: hymns));
  }
}

class HymnLyrics extends StatelessWidget {
  int hymnIndex;
  String hymn = '';

  List<TaskModel> tasks = [];

  HymnLyrics({required this.hymnIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString("load_json/hymns.json"),
          builder: (context, snapshot) {
            mydata = json.decode(snapshot.data.toString());
            // + 'hbuhgu';
            //print(hymn);
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      //Hymn Number and Mita
                      Container(
                        padding: EdgeInsets.all(20),
                        //color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Section of the hymn
                            Text(
                              mydata[hymnIndex]['section'],
                              style: TextStyle(
                                  fontSize: 15,
                                  //color: Colors.black,
                                  //fontWeight: FontWeight.w600,
                                  fontFamily: 'Amiri'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Divider(),

                            //Number of the hymn
                            Text(
                              mydata[hymnIndex]['number'],
                              style: TextStyle(
                                  fontSize: 30,
                                  //color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Amiri'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            // Mita of the hymn
                            SelectableText(
                              mydata[hymnIndex]['mita'],
                              style: TextStyle(
                                  fontSize: 18,
                                  //color: Colors.black54,
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 10),
                            Divider(),
                            Divider(),
                          ],
                        ),
                      ),

                      Container(
                        // color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              //color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  SelectableText(
                                    mydata[hymnIndex]['body'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        wordSpacing: 4,
                                        height: 1.7,
                                        // color: Colors.black54,
                                        fontFamily: 'Amiri',
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
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

                      //The Hymn Lyrics
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
