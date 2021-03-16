class Nganh{
  int _manganh;
  String _tennganh;

  int get manganh{
    return _manganh;
  }

  String get tennganh{
    return _tennganh;
  }

  Nganh(int manganh, String tenganh){
    this._manganh = manganh;
    this._tennganh = tenganh;
  }

  factory Nganh.fromMap(Map<String, dynamic> json) => new Nganh(json["manganh"], json["tennganh"]);

  Map<String, dynamic> toMap() => {
    "manghanh": _manganh,
    "tennganh": _tennganh
  };

  @override
  bool operator ==(other) => other != null && other is Nganh && other.manganh == manganh;

  @override
  int get hashCode => manganh.hashCode;
}