import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/objects/SinhVien.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoCard extends StatelessWidget{
  final String studentID;
  InfoCard({Key key, this.studentID}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBHelper.db.getSinhVien(studentID),
      builder: (BuildContext context, AsyncSnapshot<SinhVien> snapshot){
        return snapshot.hasData
            ? Expanded(
            flex: 10,
            child: Card(
                child:Container(
                    padding: EdgeInsets.all(5.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                              maxRadius: 60.0,
                              backgroundColor: Colors.grey.shade300,
                              child: CircleAvatar(
                                maxRadius: 57.0,
                              )
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Text("MSSV: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(snapshot.data.mssv)
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Họ tên: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: Text(snapshot.data.hoten)
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 7.0),),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Text("Ngày sinh: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.ngaysinh),
                                  ],
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Text("Giới tính: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(snapshot.data.phai?"Nam":"Nữ")
                                  ],
                                )
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 7.0),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Địa chỉ: ", style: TextStyle(fontWeight: FontWeight.bold),),
                            Expanded(
                                child:Text(snapshot.data.diachi)
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 7.0),),
                        Row(
                          children: [
                            Text("SDT: ", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("0${snapshot.data.sdt}")
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 7.0),),
                      ],
                    )
                )
            )
        )
            : Center(child: CircularProgressIndicator());
      }
    );
  }
}