class SinhVien {
  String _mssv;
  String _hoten;
  String _ngaysinh;
  String _diachi;
  bool _phai;
  String _sdt;
  String _matkhau;

  String get mssv => _mssv;
  String get hoten => _hoten;
  String get ngaysinh => _ngaysinh;
  String get diachi => _diachi;
  bool get phai => _phai;
  String get sdt => _sdt;
  String get matkhau => _matkhau;

  SinhVien(String mssv, String hoten, String ngaysinh, String diachi, bool phai, String sdt, String matkhau){
    this._mssv = mssv;
    this._hoten = hoten;
    this._ngaysinh = ngaysinh;
    this._diachi = diachi;
    this._phai = phai;
    this._sdt = sdt;
    this._matkhau = matkhau;
  }

  factory SinhVien.fromMap(Map<String, dynamic> json) => new SinhVien(json["mssv"], json["hoten"], json["ngaysinh"], json["diachi"], json["phai"] == 1, json["SDT"].toString(), json["matkhau"]);

  Map<String, dynamic> toMap() => {
    "mssv": _mssv,
    "hoten": _hoten,
    "ngaysinh": _ngaysinh,
    "diachi": _diachi,
    "phai": _phai,
    "sdt": _sdt,
    "matkhau": _matkhau
  };
}