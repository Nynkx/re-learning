import 'package:dk_hoc_trano/addnewclass.dart';
import 'package:dk_hoc_trano/class_description.dart';
import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/objects/Lop.dart';
import 'package:dk_hoc_trano/widgets/modalbottomsheet.dart';
import 'package:flutter/material.dart';


class ClassList extends StatefulWidget{
  final String studentID;
  ClassList({Key key, @required this.studentID}) : super(key: key);

  _ClassListState createState() => _ClassListState();

}

class _ClassListState extends State<ClassList>{
  bool _isJoined = false;
  int mahp;
  Future<List<Lop>> _futDSLop;

  refresh(int mhp){
    setState(() {
      mahp = mhp;
    });
  }

  @override
  void initState() {
    super.initState();
    mahp = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0.0,
        actions: [
          AbsorbPointer(
              absorbing: mahp==null,
              child: Opacity(
                opacity: mahp==null?0.0:1.0,
                child: FlatButton(
                  textColor: Colors.redAccent,
                  child: Row(
                    children: [
                      Text("Xóa bộ lọc"),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
                      Icon(Icons.close)
                    ],
                  ),
                  onPressed: (){
                    setState(() {
                      mahp = null;
                    });
                  },
                ),
              )
          ),
          FlatButton(
            child: Row(
              children: [
                Text("Lọc"),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2.5)),
                Icon(Icons.filter_list)
              ],
            ),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc){
                    return ModalBottomSheet(notifyParent: refresh,);
                  }
                  );
            },
          ),

        ],
      ),
        body: FutureBuilder<List<Lop>>(
            future: mahp==null?DBHelper.db.getAllLop():DBHelper.db.getLopTheoHocPhan(mahp),
            builder: (BuildContext context, AsyncSnapshot<List<Lop>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Lop itemLop = snapshot.data[index];
                      return Card(
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top:10.0, bottom: 10, right: 24.0),
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
                                      child:Text(itemLop.tenlop, textAlign: TextAlign.left, style: TextStyle(fontSize: 20.0)),
                                    padding: EdgeInsets.only(bottom: 10.0),
                                  ),
                                  itemLop.trangthai == 0 ? Text("Chưa mở", textAlign: TextAlign.left, style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic))
                                      :Text("Đã mở lớp", textAlign: TextAlign.left, style: TextStyle(color: Colors.green, fontStyle: FontStyle.italic)),
                                ],
                              )
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  ClassDescription(classID: itemLop.malop, studentID: widget.studentID,)));
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                          )
                      );
                    }
                );
              } else
                return Center(child: CircularProgressIndicator());
            }
        ),

        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewClass()));
              setState(() {

              });
            },
            tooltip: "Thêm lớp mới",
            child: Icon(Icons.add)
        ),
      );
  }
}