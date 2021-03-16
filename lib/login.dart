import 'dart:async';

import 'package:dk_hoc_trano/objects/DBHelper.dart';
import 'package:dk_hoc_trano/widgets/myscrollbehavior.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super (key:key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen>{

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _mssvController = TextEditingController();
  TextEditingController _matkhauController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bc = context;
    return Scaffold(
        body: Builder(
          builder: (BuildContext bc){
            return Center(
                child: ScrollConfiguration(
                    behavior: MyScrollBehavior(),
                    child: SingleChildScrollView(
                        child: GestureDetector(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                            },
                            child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                        "assets/images/new_logo.png",
                                        fit: BoxFit.cover
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Container(
                                          padding: EdgeInsets.only(left: 40, right: 40),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(padding: EdgeInsets.only(top:5.0, bottom:5.0),),
                                              TextFormField(
                                                controller: _mssvController,
                                                validator: (value){
                                                  if(value.isEmpty){
                                                    return "Vui lòng nhập thông tin!";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    labelText: "Mã Sinh Viên"
                                                ),
                                                keyboardType: TextInputType.number,
                                              ),
                                              Padding(padding: EdgeInsets.only(top:5.0, bottom:5.0),),
                                              TextFormField(
                                                controller: _matkhauController,
                                                validator: (value){
                                                  if(value.isEmpty){
                                                    return "Vui lòng nhập thông tin!";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    labelText: "Mật Khẩu"
                                                ),
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.redAccent,
                                      textColor: Colors.white,
                                      child: new Text("Đăng Nhập"),
                                      onPressed: (){
                                        FocusScope.of(context).unfocus();
                                        if(_formKey.currentState.validate()){
                                          String mssv = _mssvController.text;
                                          String matkhau = _matkhauController.text;

                                          DBHelper.db.getSinhVien(mssv).then((res){
                                            if(res != null && res.matkhau == matkhau){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Đăng ký học trả nợ", mssv: mssv,)));
                                            }
                                            else{
                                              final snackBar = SnackBar(
                                                  content: Text("Đăng nhâp thất bại!")
                                              );
                                              Scaffold.of(bc).showSnackBar(snackBar);
                                            }
                                            return null;
                                          });
                                        }
                                      },
                                      splashColor: Colors.blue,
                                    ),
                                  ],
                                )
                            )
                        )
                    )
                )
            );
          },
        )
    );
  }
}
