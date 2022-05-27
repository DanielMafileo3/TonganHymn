// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:tonganhymn/appthemes.dart';
import 'package:tonganhymn/database.dart';
import 'package:tonganhymn/datasearch.dart';
import 'package:tonganhymn/extrahymnlist.dart';
import 'package:tonganhymn/favorites.dart';
import 'package:tonganhymn/hymnlist.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String? title;
  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List data;
  List<String> titles = [];
  HymnList hymn = HymnList();
  bool isDay = true;

  int setCurrent(int i) {
    _currentIndex = i;
    return _currentIndex;
  }

  Future<String?> loadHymnAsset() async {
    var jsonText = await rootBundle.loadString('load_json/hymns.json');
    setState(() {
      data = json.decode(jsonText);
    });

    for (int i = 0; i <= 359; i++) {
      titles.add(data[i]['title']);
    }
  }

  @override
  void initState() {
    this.loadHymnAsset();
    //changeColor();
  }

  Widget pageView = PageView(
      controller: PageController(initialPage: 0),
      children: <Widget>[HymnList(), ExtraHymnList()]);

  Widget icon(int count) {
    if (count == 1 || count == 3) {
      return IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.orange[900],
          ),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          });
    } else {
      return Container();
    }
  }

  //bool isWhite = true;
  var col = Colors.white;

  // Color getColor(){
  //   Color textColors = whitet;
  //   //setState(() {
  //     if(textColors == Colors.black87){
  //       textColors = whitet;
  //      // isWhite = false;
  //      return textColors;
  //     }
  //     else if(textColors == whitet){
  //       textColors = Colors.black87;
  //       //isWhite = true;
  //       return textColors;
  //     }
  //     //return col;
  //  // });

  //   //return col;
  // }

  static const MaterialColor whitet =
      const MaterialColor(0xFFFFFFFF, const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF)
  });

  void changeBrightness() {
    // DynamicTheme.of(context).setTheme(
    //     Theme.of(context).brightness == Brightness.dark
    //         ? Brightness.light
    //         : Brightness.dark);

    // color: Theme.of(context).colorScheme == Colors.red? Colors.white : Colors.red;

    setState(() {
      if (isDay == true) {
        isDay = false;
        DynamicTheme.of(context)?.setTheme(AppThemes.lightDay);
        titleColor = Colors.white;
      } else {
        isDay = true;
        DynamicTheme.of(context)?.setTheme(AppThemes.darkNight);
        titleColor = Colors.orange[900];
      }

      if (col == whitet) {
        col = Colors.black38;
        // isWhite = false;
      } else if (col == Colors.black38) {
        col = whitet;
        //isWhite = true;
      }
    });
  }

  Color? themeColor = Colors.orange[900];
  Color? titleColor = Colors.orange[900];
  //Color iconColors = Colors.red;

  void changeColor() {
    // DynamicTheme.of(context).setTheme(new ThemeData(
    //     primaryColor: Theme.of(context).primaryColor == whitet ? Colors.orange[900] : whitet
    // )

    // );

    setState(() {
      if (Theme.of(context).primaryColor == whitet) {
        themeColor = Colors.orange[900];
        titleColor = Colors.white;
      } else {
        themeColor = Colors.red;
        titleColor = Colors.red;
      }
    });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.orange[900]),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    _launchNumber() async {
      const url = 'tel:+61421819757';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    _launchEmail() async {
      const url = 'mailto:utol.technology@gmail.com';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Siasi 'O Tonga Tau'ataina Hymn App"),
      content: Container(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text:
                    'Malo aupito kainga.\n\nKapau oku iai ha tokoni ke toe fakalakalaka ange ae meani pea kapau oku iai ha launga kataki fetutaki mai:\n\n',
                style: TextStyle(color: Colors.black)),
            TextSpan(text: 'Telefoni: ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "+61421819757\n\n",
                style: TextStyle(color: Colors.orange[900]),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchNumber();
                  }),
            TextSpan(text: 'Email: ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "utol.technology@gmail.com\n\n",
                style: TextStyle(color: Colors.orange[900]),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchEmail();
                  }),
            TextSpan(
                text: 'Instagram: ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "@utol.tech\n\n",
                style: TextStyle(color: Colors.orange[900]),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://www.instagram.com/utol_tech/');
                  }),
            TextSpan(text: 'Facebook: ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "Utol Tech\n\n",
                style: TextStyle(color: Colors.orange[900]),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(
                        'https://www.facebook.com/utol.tech/?modal=admin_todo_tour');
                  }),
            TextSpan(text: 'Website: ', style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "mafileo.github.io\n\n",
                style: TextStyle(color: Colors.orange[900]),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch('https://mafileo.github.io/');
                  }),
          ]),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //changeColor();
    final TodoHelper _todoHelper = TodoHelper();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.amber,
        title: Text(
          'NGAAHI HIVA HIMI',
          style: TextStyle(fontFamily: 'Amiri', color: titleColor),
        ),
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
              //changeColor();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/sttlogored.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.orange[900],
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          Stack(
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/Free_Church_of_Tonga.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Container()),
              Opacity(
                opacity: 0.9,
                child: Container(
                  height: 180,
                  width: 500,
                  //padding: EdgeInsets.all(200),
                  color: themeColor,
                  child: Column(children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      // width: 200,
                      child: Image.asset(
                          'assets/images/sttlogowhiteandredheader.png'),
                    ),
                    Text(
                      "Siasi 'O Tonga Tau'ataina",
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Amiri'),
                    ),
                    Text(
                      'Hymn App',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ]),
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(
              MdiIcons.library,
              color: themeColor,
            ),
            title: Text("My Hymns"),
            onTap: () async {
              List<TaskModel> list = await _todoHelper.getAllTask();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Favorites(list: list)));
            },
          ),
          ListTile(
            leading: Icon(
              MdiIcons.mail,
              color: themeColor,
            ),
            title: Text("Feedback"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              MdiIcons.share,
              color: themeColor,
            ),
            title: Text("Share"),
            onTap: () {
              Share.share(
                  'check out my website https://pub.dev/packages/url_launcher#-readme-tab-');
            },
          ),
          ListTile(
            leading: Icon(
              MdiIcons.contacts,
              color: themeColor,
            ),
            title: Text("Contact Us"),
            onTap: () {
              Navigator.of(context).pop();
              showAlertDialog(context);
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     MdiIcons.school,
          //     color: themeColor,
          //   ),
          //   title: Text("Go Tailulu"),
          //   onTap: () {
          //     //getColor();
          //   //   getColor();
          //   changeColor();
          //    //changeBrightness();
          //   },
          // ),
          ListTile(
            leading: Icon(
              MdiIcons.weatherNight,
              color: themeColor,
            ),
            title: Text("Night/Day Mode"),
            onTap: () {
              //getColor();
              //   getColor();
              //changeColor();
              changeBrightness();
            },
          ),
        ]),
      ),
      body: HymnList(),
    );
  }
}
