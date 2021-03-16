import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget{
  final Function(int) notifyParent;
  final int currentIndex;
  CustomBottomAppBar({Key key, @required this.notifyParent, @required this.currentIndex}) : super(key: key);

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar>{

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Trang chủ"),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_list),
                title: Text("Danh sách lớp")
            )
          ],
          selectedItemColor: Colors.amber[800],
          currentIndex: widget.currentIndex,
          onTap: widget.notifyParent,
        )
    );
  }
}