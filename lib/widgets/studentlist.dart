import 'package:dk_hoc_trano/objects/SinhVien.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget{

  final Future<List<SinhVien>> futDSSV;
  StudentList({Key key, this.futDSSV}) : super (key: key);



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futDSSV,
      builder: (BuildContext context, AsyncSnapshot<List<SinhVien>> snapshot){
        return snapshot.hasData
            ? Expanded(
            child:ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                SinhVien sv = snapshot.data[index];
                return Card(
                    child:ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top:10.0, bottom: 10, right:(index+1)~/10 == 0? 34.0: 24.0),
                            child: Text('${index+1}', style: TextStyle(fontSize: 20.0),),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.grey.shade300)
                                )
                            ),
                          )
                        ],
                      ),
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                sv.hoten,
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "MSSV: ${sv.mssv}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
            )
        ): Center(child: CircularProgressIndicator());
      },
    );
  }
}