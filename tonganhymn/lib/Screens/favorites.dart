// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tonganhymn/Models/database.dart';
import 'package:tonganhymn/Screens/favoriteshymns.dart';
import 'package:tonganhymn/Screens/homepage.dart';
import 'package:tonganhymn/Screens/hymn.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Favorites extends StatefulWidget {
  final List<TaskModel> list;

  Favorites({required this.list});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Favorites> {
  List<TaskModel> tasks = [];

  TaskModel? currentTask;
  List<int> page = [];

  @override
  initState() {
    setState(() {
      tasks = widget.list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TodoHelper _todoHelper = TodoHelper();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        // backgroundColor: Colors.white,
        title: Text(
          'My Hymns',
          style: TextStyle(
              //fontFamily: 'Nanum Gothic',
              //color: Colors.orange[900],
              fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Container(
        //padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    child: ListTile(
                      leading: Text("${tasks[index].number}"),
                      title: Text("${tasks[index].title}"),
                      subtitle: Text("${tasks[index].mita}"),
                      onTap: () {
                        int i = int.parse(tasks[index].number) - 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteHymn(
                                      indexNUm: i,
                                      l: widget.list,
                                    )));
                      },
                    ),
                    background: Container(
                      alignment: AlignmentDirectional.centerStart,
                      color: Colors.orange[900],
                      child: Icon(
                        MdiIcons.delete,
                        color: Colors.white,
                      ),
                    ),
                    key: ValueKey(tasks[index]),
                    onDismissed: (direction) {
                      setState(() {
                        _todoHelper.delete(tasks[index].id);
                        tasks.removeAt(index);
                        //currentTask = TaskModel(number: tasks[index].number, mita: tasks[index].mita, title: tasks[index].title);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: tasks.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
