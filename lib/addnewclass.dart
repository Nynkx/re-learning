import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/objects/Nganh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'objects/HocPhan.dart';
import 'objects/Lop.dart';

class AddNewClass extends StatefulWidget{
  AddNewClass({Key key}): super(key: key);

  _AddNewClassState createState() => _AddNewClassState();
}

class _AddNewClassState extends State<AddNewClass>{

  final _formKey = GlobalKey<FormState>();

  TextEditingController _tenlopController = TextEditingController();

  Nganh _selectedNganh;
  HocPhan _selectedHocPhan;
  bool _isChose = false;

  List<Nganh> lstNganh = <Nganh>[Nganh(1, "aa"), Nganh(2, "bb")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm lớp mới"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _tenlopController,
                        decoration: InputDecoration(hintText: "Tên lớp"),
                        validator: (value){
                          if (value.isEmpty)
                          {
                            return "Vui lòng nhập thông tin!";
                          }
                          return null;
                        }
                    ),
                    FutureBuilder<List<Nganh>>(
                      future: DBHelper.db.getAllNganh(),
                      builder: (BuildContext context, AsyncSnapshot<List<Nganh>> snapshot){
                        if(snapshot.hasData) {
                            return
                              DropdownButton<Nganh>(
                                hint: Text("Chọn ngành"),
                                value: _selectedNganh,
                                isExpanded: true,
                                items: snapshot.data.map((nganh){
                                  return DropdownMenuItem<Nganh>(
                                    value: nganh,
                                    child: Text(nganh.tennganh)
                                  );
                                }).toList(),
                                onChanged: (Nganh nganh){
                                  setState(() {
                                    print(_selectedNganh);
                                    print(nganh);
                                    _selectedHocPhan = null;
                                    _selectedNganh = nganh;
                                    _isChose = false;
                                  });
                                },
                            );
                          }
                        else
                          return CircularProgressIndicator();
                      },
                    ),
                    FutureBuilder<List<HocPhan>>(
                      future: DBHelper.db.getHocPhanTheoNganh(_selectedNganh),
                      builder: (BuildContext context, AsyncSnapshot<List<HocPhan>> snapshot){
                        if(snapshot.hasData) {
                          return
                            DropdownButton<HocPhan>(
                              hint: Text("Chọn học phần"),
                              value: _selectedHocPhan,
                              isExpanded: true,
                              items: snapshot.data.map((hocphan){
                                return DropdownMenuItem<HocPhan>(
                                    value: hocphan,
                                    child: Text(hocphan.tenhp)
                                );
                              }).toList(),
                              onChanged: (HocPhan hocphan){
                                setState(() {
                                  print(_selectedHocPhan);
                                  print(hocphan.mahp);
                                  _selectedHocPhan = hocphan;
                                  _isChose = true;
                                });
                              },

                            );
                        }
                        else
                          return CircularProgressIndicator();
                      },

                    ),

                    AbsorbPointer(
                      absorbing: !_isChose,
                      child: Container(
                        child: RaisedButton(
                          onPressed: (){
                            if (_formKey.currentState.validate()){
                              String tenlop = _tenlopController.text;
                              Lop lop = Lop(null, tenlop, 0,  _selectedHocPhan.mahp);

                              DBHelper.db.newLop(lop);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Thêm")
                        )
                      )
                    )
                  ]
              )
          )
        )
    );
  }
}