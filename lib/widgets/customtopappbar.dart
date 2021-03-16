import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget{
  @override
  final Size preferredSize;

  final String title;
  final List<String> lstMenu = <String>["Đăng xuất", "Thoát"];

  TopAppBar(this.title, {Key key}) : preferredSize = Size.fromHeight(55.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(this.title, textAlign: TextAlign.center,),
      actions: <Widget>[

      ],
    );
  }
}