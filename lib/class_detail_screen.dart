import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class GallerySection extends StatelessWidget{
  final String text;
  final Color bgColor;

  GallerySection({Key key, this.text, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
      child: Center(
        child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      color: bgColor,
    );
  }
}


class InfoRow extends StatelessWidget{
  final String title;
  final String text;

  InfoRow({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}


class ClassDetail extends StatefulWidget {
  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  bool _isButtonDisabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isButtonDisabled = false;
  }

  void _changeState(BuildContext context) {
    setState(() {
      _isButtonDisabled = true;
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Đã đăng ký thành công'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  Widget _SigninButon(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(_isButtonDisabled ? 'Đã đăng ký' : 'Đăng ký',
          style: TextStyle(fontSize: 20)),
      onPressed: _isButtonDisabled ? null : () => _changeState(context),
      color: Colors.blue,
      textColor: Colors.white,
      elevation: 5,
    );
  }
}




