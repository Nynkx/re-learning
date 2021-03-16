
import 'dart:convert';

Lop lopFromJSON(String str){
  final jsonData = json.decode(str);
  return Lop.fromMap(jsonData);
}



class Lop {
  int _malop;
  String _tenlop;
  int _trangthai;
  int _mahp;

  Lop(int malop, String tenlop, int trangthai, int mahp){
    this._malop = malop;
    this._tenlop = tenlop;
    this._trangthai = trangthai;
    this._mahp = mahp;
  }

  int get malop => _malop;
  String get tenlop => _tenlop;
  int get trangthai => _trangthai;
  int get mahp => _mahp;

  factory Lop.fromMap(Map<String, dynamic> json) => new Lop(json["malop"], json["tenlop"], json["trangthai"], json["mahp"]);

  Map<String, dynamic> toMap() => {
    "malop": malop,
    "tenlop": tenlop,
    "trangthai": trangthai,
    "mahp": mahp
  };

}