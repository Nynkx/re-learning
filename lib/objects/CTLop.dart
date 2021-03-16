class CTLop{
  String _mssv;
  int _malop;

  String get mssv => _mssv;
  int get malop => _malop;

  CTLop(String mssv, int malop){
    this._mssv = mssv;
    this._malop = malop;
  }

  factory CTLop.fromMap(Map<String, dynamic> json) => new CTLop(json['mssv'], json['malop']);

  Map<String, dynamic> toMap() => {
    "mssv": mssv,
    "malop": malop
  };
}