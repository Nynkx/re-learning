import 'dart:ui';

import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/objects/Lop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../class_description.dart';


class ListClass extends StatefulWidget{
  final String mssv;

  ListClass({Key key, @required this.mssv}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListClassState();
  }

}

class ListClassState extends State<ListClass>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: DBHelper.db.getLopTheoSinhVien(widget.mssv),
      builder: (BuildContext context, AsyncSnapshot<List<Lop>> snapshot){
        return snapshot.hasData
            ? Expanded(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                Lop lop = snapshot.data[index];

                return _row(context, index, lop, widget.mssv);
              }
          )
        )
            : Center(child:CircularProgressIndicator());
      }
    );
  }
}

Widget _row(BuildContext context, int index, Lop lop, String mssv){
  final color = index % 2 == 0 ? Colors.lightBlueAccent : Colors.cyanAccent;
  return Container(

    padding: EdgeInsets.all(5.0),
    height: 150.0,
    child: Card(
      color: color,
      child: ListTile(
        title: Container(
          height: 50.0,
          width: 200.0,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width: 3.0))),
          child: Text(lop.tenlop,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 10),
                child: Text('Mã lớp: ${lop.malop.toString()}',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left)
            ),
          ],
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              ClassDescription(classID: lop.malop, studentID: mssv,)));
        },
      ),
    ),
  );
}