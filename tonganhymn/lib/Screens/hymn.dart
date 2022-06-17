// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tonganhymn/Models/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:share/share.dart';

//TaskModel currentTask;
var mydata;
int? currentPage;
//final TodoHelper _todoHelper = TodoHelper();
bool? hasChangedPages;

class Hymn extends StatefulWidget {
  late TaskModel currentTask;
  int? index;
  final TodoHelper _todoHelper = TodoHelper();

  Hymn(int hymnindex) {
    index = hymnindex;
    currentPage = hymnindex;
    hasChangedPages = false;
  }

  @override
  _Hymn createState() => _Hymn();
}

class _Hymn extends State<Hymn> {
  // int? hymnIindex = widget.index;
  List<Widget> hymns = [];
  // static int num = widget.index;
  // List<String> titles = [];
  // List data;
  // int count = 0;

  String? section;
  String? number;
  String? mita;
  String? lyrics;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // _Hymn(int index) {
  //   print('number constructor');
  //   hymnIindex = index;
  //   num = hymnIindex;
  //   getHymns();
  //   print(num);
  // }

  List<Widget> getHymns() {
    for (int i = 0; i < 360; i++) {
      hymns.add(HymnLiyrics(i));
    }

    return hymns;
  }

  int pagenum = 2;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //  super.initState();
  //   if(Theme.of(context).brightness == Brightness.dark){
  //    print('dark');

  //   }
  //   else if(Theme.of(context).brightness == Brightness.light){
  //    print('light');

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    getHymns();
    print('hymn build being called');
    //home.createState().setCurrent(1);

    if (widget.index.toString().contains(new RegExp(r'[a-z]'))) {
      print('int not int');
      return Scaffold(
        body: Container(
          child: Center(
            child: Text(
              'Kataki toe kumi atu ha himi e taha',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    } else if (widget.index! > 360) {
      return Scaffold(
        body: Container(
          child: Center(
            child: Text(
              'Kataki toe kumi atu ha himi e taha',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
    } else {
      print('go thruhhhhh');
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.orange[900],
            iconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange[900],
              child: Icon(
                MdiIcons.library,
                color: Colors.white,
              ),
              onPressed: () {
                if (hasChangedPages == true) {
                  widget.currentTask = TaskModel(
                      number: mydata[pagenum]['number'],
                      mita: mydata[pagenum]['mita'],
                      title: mydata[pagenum]['title'],
                      id: 0);
                  print(widget.currentTask.id);

                  widget._todoHelper.insertTask(widget.currentTask);
                } else if (hasChangedPages == false) {
                  widget.currentTask = TaskModel(
                      number: mydata[currentPage]['number'],
                      mita: mydata[currentPage]['mita'],
                      title: mydata[currentPage]['title'],
                      id: 0);
                  print(widget.currentTask.id);
                  widget._todoHelper.insertTask(widget.currentTask);
                }

                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text('Added to My Hymns'),
                ));
              }),
          body: PageView(
              onPageChanged: _onprintPageViewChange,
              controller: PageController(initialPage: widget.index!),
              children: hymns));
    }
  }

  _onprintPageViewChange(int page) {
    print("Page: " + page.toString());

    pagenum = page;
    hasChangedPages = true;
  }
}

class HymnLiyrics extends StatelessWidget {
  int? hymnIndex;
  String hymn = '';

  List<TaskModel> tasks = [];

  HymnLiyrics(int i) {
    hymnIndex = i;
    //currentPage = i + 1;
  }

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
                              //materialTextSelectionControls.
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
                                    //color.
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
