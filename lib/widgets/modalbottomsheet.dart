import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/objects/HocPhan.dart';
import 'package:dk_hoc_trano/objects/Nganh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalBottomSheet extends StatefulWidget{
  final Function(int) notifyParent;

  ModalBottomSheet({Key key, this.notifyParent}) : super(key:key);

  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>{
  Nganh _selectedNganh;
  HocPhan _selectedHocPhan;
  bool _isChose;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
        child: Wrap(
          children: [
            Column(
              children: [
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
                RaisedButton(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text("Lọc"),
                  onPressed: (){
                    widget.notifyParent(_isChose?_selectedHocPhan.mahp:null);
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        )
    );
  }
}