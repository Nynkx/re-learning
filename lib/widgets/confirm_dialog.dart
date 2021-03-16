import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget{

  final String title;
  final String content;

  final Function() onConfirm;
  final Function() onCancel;

  ConfirmDialog({Key key, this.title, this.content, this.onConfirm, this.onCancel}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: Text("Hủy"),
          onPressed: onCancel,
        ),
        FlatButton(
          child: Text("Đồng ý"),
          onPressed: onConfirm,
        ),
      ],
    );
  }

}