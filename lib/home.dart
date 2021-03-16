import 'package:dk_hoc_trano/about_screen.dart';
import 'package:dk_hoc_trano/login.dart';
import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'objects/SinhVien.dart';
import 'widgets/customtopappbar.dart';
import 'widgets/custombottomappbar.dart';
import 'class_list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.mssv}) : super(key: key);

  final String title;
  final String mssv;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  int _sIndex = 0;

  SinhVien sv;

  List<Widget> _widgetOptions;

  // PageController _pageController = PageController();

  getTappedItem(int index){
    setState(() {
      _sIndex = index;
      // _pageController.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      AboutScreen(studentID: widget.mssv),
      ClassList(studentID: widget.mssv,)
    ];
  }

  @override
  Widget build(BuildContext context) {


    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: TopAppBar(widget.title),
      // body: PageView(
      //   controller: _pageController,
      //   onPageChanged: (index) => setState(() {
      //     _sIndex = index;
      //   }),
      //   children: _widgetOptions,
      // ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<SinhVien>(
              future: DBHelper.db.getSinhVien(widget.mssv),
              builder: (context, AsyncSnapshot<SinhVien> snapshot){
                return snapshot.hasData
                    ? DrawerHeader(
                  padding: EdgeInsets.all(7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    maxRadius: 50.0,
                                    backgroundColor: Colors.grey.shade300,
                                    child: CircleAvatar(
                                        maxRadius: 47.0,
                                        backgroundColor: Colors.grey.shade400,
                                        child: Text("SV", style: TextStyle(fontSize: 30.0)),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.only(top: 15.0, left: 10.0, bottom: 10.0),
                                              child: Text(
                                                "MSSV:${snapshot.data.mssv}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,

                                                ),
                                              )
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                "${snapshot.data.hoten}",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white
                                                ),
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              )
                            ],
                          )
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                )
                    : CircularProgressIndicator();
              }
            ),
            ListTile(
              title: Text("Đăng xuất"),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              title: Text("Thoát"),
              onTap: (){
                SystemNavigator.pop();
              },
            )
          ],
        )
      ),
      body: _widgetOptions[_sIndex],
      bottomNavigationBar: CustomBottomAppBar(notifyParent: getTappedItem, currentIndex: _sIndex),
    );
  }
}