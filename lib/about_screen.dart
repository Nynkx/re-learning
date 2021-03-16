import 'package:dk_hoc_trano/widgets/infocard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/list_class.dart';





class AboutScreen extends StatelessWidget {
  final String studentID;

  AboutScreen({Key key, this.studentID}): super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 5.0)),
              InfoCard(studentID: studentID),
              Padding(padding: EdgeInsets.only(left: 5.0)),
            ],
          ),
          ListClass(mssv: studentID)
        ],
      ),
    );
  }
  
}