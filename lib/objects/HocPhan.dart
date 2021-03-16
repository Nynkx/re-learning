class HocPhan{
  int _mahp;
  String _tenhp;

  int get mahp => _mahp;

  String get tenhp => _tenhp;


  HocPhan(int mahp, String tenhp){
    this._mahp = mahp;
    this._tenhp = tenhp;
  }

  factory HocPhan.fromMap(Map<String, dynamic> json) => new HocPhan(json['mahp'], json['tenhp']);

  Map<String, dynamic> toMap() => {
    "mahp": mahp,
    "tenhp": tenhp
  };

  @override
  bool operator ==(other) => other != null && other is HocPhan && other.mahp == mahp;

  @override
  int get hashCode => mahp.hashCode;
}