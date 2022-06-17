// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tonganhymn/Screens/hymn.dart';

class DataSearch extends SearchDelegate<String> {
  List hymnHistory = [];
  List? data;
  List<String> titles = [];
  List<String> indexTitles = [];
  int count = 0;

  Future<String?> loadHymnAsset() async {
    var jsonText = await rootBundle.loadString('load_json/hymns.json');
    //setState(() {
    data = json.decode(jsonText);
    //});

    for (int i = 0; i <= 359; i++) {
      //titles.add(data[i]['number']);
      count++;
      titles.add('$count.  ' + data![i]['title'].toString().toLowerCase());
      titles.add(data![i]['title'].toString().toLowerCase());
      indexTitles.add(data![i]['title'].toString().toLowerCase());
      //print('$i  ' + data[i]['title']);
    }
  }

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.orange[900],
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  Widget showError(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('data'),
      content: Text('fdfsfdsfs'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
    return Container();
  }

  DataSearch() {
    loadHymnAsset();
  }

  @override
  String get searchFieldLabel => 'Fekumi';

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          color: Colors.white,
          icon: Icon(Icons.clear),
          onPressed: () {
            //   try{
            query = '';
            // }
            // catch(e){
            //   print('clear error caught');
            // }
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar

    return IconButton(
        icon: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //show some results based on the selection

    int? num;
    int? indexHymn;
    int? hymnNum;
    String queryHymn = query;
    final iReg = RegExp(r'(\d+)');
    print('queryHymn: ' + queryHymn);

    for (String s in indexTitles) {
      if (s == queryHymn) {
        print('s: ' + s);
        indexHymn = indexTitles.indexOf(s);
        print(indexHymn.toString());
      }
    }
    //print(this.query);
    print(iReg.allMatches(queryHymn).map((m) => m.group(0)).join(' '));
    //print(this.query);
    // try{
    //   num = int.parse(this.query)-1;
    // }catch(e){
    //   print("error");
    // }
    try {
      hymnNum = int.parse(
              iReg.allMatches(queryHymn).map((m) => m.group(0)).join(' ')) -
          1;
    } catch (e) {
      print('errorr');
    }

    //hymnHistory.add(this.query);

    try {
      if (indexHymn.toString().contains(new RegExp(r'[A-Z]'))) {
        // print('dsfdsfsfewfdsfsdvcds');
        return showError(context);
      } else if (queryHymn[0].startsWith(RegExp(r'[0-9]'))) {
        num = hymnNum! + 1;
        hymnHistory.add(num.toString() + '. ' + indexTitles[hymnNum]);
        return Hymn(hymnNum);
      } else {
        //print('else being called');
        num = indexHymn! + 1;
        hymnHistory.add(num.toString() + '. ' + indexTitles[indexHymn]);
        return Hymn(indexHymn);
      }
    } catch (e) {
      return Scaffold(
        body: Container(
          child: Center(
            child: Text(
              'Kataki toe kumi atu ha himi e taha',
              style: TextStyle(fontSize: 20, color: Colors.white38),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches for something

    final suggestionList = query.isEmpty
        ? hymnHistory
        : titles.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.library_music),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index]
                    .substring(0, query.length)
                    .toString()
                    .toLowerCase(),
                style: TextStyle(
                    color: Colors.orange[900], fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index]
                      .substring(query.length)
                      .toString()
                      .toLowerCase(),
                  //     +
                  // '  - ' +
                  // data[index]['mita'],
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
