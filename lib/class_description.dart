import 'package:dk_hoc_trano/objects/CTLop.dart';
import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/widgets/confirm_dialog.dart';
import 'package:dk_hoc_trano/widgets/studentlist.dart';
import 'package:dk_hoc_trano/widgets/threedotprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'class_detail_screen.dart';
import 'objects/HocPhan.dart';
import 'objects/Lop.dart';
import 'objects/SinhVien.dart';

class ClassDescription extends StatefulWidget{
  final int classID;
  final String studentID;

  ClassDescription({Key key, @required this.classID, @required this.studentID}) : super(key:key);

  @override
  _ClassDescriptionState createState() => _ClassDescriptionState();
}

class _ClassDescriptionState extends State<ClassDescription>{

  bool _isScrolling = false;

  ScrollController _dssvController;

  @override
  void initState(){
    super.initState();
    _dssvController = ScrollController();

    _dssvController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Chi tiết lớp"),
      ),
      body: FutureBuilder<Lop>(
        future: DBHelper.db.getLop(widget.classID),
        builder: (BuildContext context, AsyncSnapshot<Lop> snapshot){
          return snapshot.hasData
              ? Column(
            children: [
              GallerySection(text: snapshot.data.tenlop, bgColor: Colors.lightBlue),
              Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InfoRow(title: 'Mã Lớp: ', text: snapshot.data.malop.toString()),
                        FutureBuilder(
                          future: DBHelper.db.getHocPhan(snapshot.data.mahp),
                          builder: (context, AsyncSnapshot<HocPhan> snapshot){
                            if(snapshot.hasData)
                            {
                              HocPhan hp = snapshot.data;
                              return InfoRow(title: "Học phần: ", text: hp.tenhp);
                            }
                              return Center(child: CircularProgressIndicator());
                          }
                        ),
                        InfoRow(title: 'Mã HP: ', text: snapshot.data.mahp.toString()),
                        InfoRow(title: 'Trạng thái: ', text: snapshot.data.trangthai == 0 ? 'Chưa mở lớp' : 'Đã mở lớp')
                      ],
                    ),
                  )
                )
              ),
              Text(
                "Danh sách sinh viên",
                style: TextStyle(
                  fontSize: 20.0
                )
              ),
              StudentList(futDSSV: DBHelper.db.getSinhVienTheoLop(widget.classID),)
            ],
          )
              : Center(child: CircularProgressIndicator());
      }
      ),
      floatingActionButton: FutureBuilder(
        future: DBHelper.db.getSinhVienTonTaiTrongLop(widget.studentID, widget.classID),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          return snapshot.hasData
              ? AnimatedOpacity(
            child: FloatingActionButton(
              onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return ConfirmDialog(
                        title: "Thông báo",
                        content: !snapshot.data?"Tham gia?":"Rời Lớp?",
                        onConfirm: (){
                          if(!snapshot.data)
                            DBHelper.db.newSVTrongLop(CTLop(widget.studentID, widget.classID));
                          else
                            DBHelper.db.deleteSVTrongLop(CTLop(widget.studentID, widget.classID));
                          Navigator.of(context).pop();
                          setState(() {

                          });
                        },
                        onCancel: (){
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  );
                },
              child: !snapshot.data?Icon(Icons.add):Icon(Icons.clear),
              backgroundColor: !snapshot.data?Colors.blueAccent:Colors.redAccent,
            ),
            duration: Duration(milliseconds: 200),
            opacity: _isScrolling?0:1,
          )
              : Center(child: CircularProgressIndicator());
      }
      ),
    );
  }
}