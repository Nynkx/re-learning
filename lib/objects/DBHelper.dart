import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dk_hoc_trano/objects/CTLop.dart';
import 'package:dk_hoc_trano/objects/SinhVien.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Lop.dart';
import 'Nganh.dart';
import 'HocPhan.dart';



class DBHelper{

  DBHelper._();

  static final DBHelper db = DBHelper._();

  Database _database;

  Future<Database> get database async{
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, "ql_dk_hoctrano.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate:(Database db, int version) async{
      await db.execute("CREATE TABLE SINHVIEN("
          "mssv VARCHAR(8) PRIMARY KEY,"
          "hoten VARCHAR(50),"
          "ngaysinh DATE,"
          "diachi VARCHAR(100),"
          "phai BIT,"
          "SDT NUMERIC,"
          "matkhau VARCHAR(50)"
          ")");
      await db.execute("CREATE TABLE GIAOVIEN("
          "magv VARCHAR(8) PRIMARY KEY,"
          "hoten VARCHAR(50),"
          "ngaysinh DATE,"
          "phai BIT,"
          "diachi VARCHAR(100),"
          "sdt NUMERIC"
          ")");
      await db.execute("CREATE TABLE HOCPHAN("
          "mahp INTEGER PRIMARY KEY AUTOINCREMENT,"
          "tenhp VARCHAR(100)"
          ")");
      await db.execute("CREATE TABLE LOP("
          "malop INTEGER PRIMARY KEY AUTOINCREMENT,"
          "tenlop VARCHAR(100),"
          "trangthai int,"
          "mahp INTEGER,"
          "FOREIGN KEY (mahp) references HOCPHAN(mahp)"
          ")");

      await db.execute("CREATE TABLE NGANH("
          "manganh INTEGER PRIMARY KEY AUTOINCREMENT,"
          "tennganh VARCHAR(100)"
          ")");
      await db.execute("CREATE TABLE CTLOP("
          "mssv VARCHAR(8),"
          "malop INTEGER,"
          "PRIMARY KEY (mssv, malop),"
          "FOREIGN KEY(mssv) REFERENCES SINHVIEN(mssv),"
          "FOREIGN KEY(malop) REFERENCES LOP(malop)"
          ")");
      await db.execute("CREATE TABLE CTNGANH("
          "manganh INTEGER,"
          "mahp INTEGER,"
          "FOREIGN KEY(manganh) REFERENCES NGANH(manganh),"
          "FOREIGN KEY(mahp) REFERENCES LOP(mahp)"
          ")");

      String sqlData = await rootBundle.loadString("assets/data.sql");
      var batch = db.batch();
      const LineSplitter().convert(sqlData).forEach((cmd){
        db.execute(cmd);
      });
      await batch.commit();


      // await db.execute("insert into lop values(null, 'Kỹ thuật lập trình: Thêm một lần đau', 0, 2)");
      // await db.execute("insert into lop values(null, 'Lớp học lại môn CorelDRAW', 1, 6)");
      // await db.execute("insert into lop values(null, 'Lớp Photoshop trả nợ nhanh ra trường nào', 0, 4)");

      // await db.execute("insert into ctlop values('18005065',2)");
      // await db.execute("insert into ctlop values('18004765',2)");
      // await db.execute("insert into ctlop values('18004587',2)");
      // await db.execute("insert into ctlop values('18005130',2)");
      // await db.execute("insert into ctlop values('18004826',2)");
      // await db.execute("insert into ctlop values('18004421',2)");
    });

  }

  newLop(Lop lop) async{
    final db = await database;
    var res = await db.insert("LOP", lop.toMap());
    return res;
  }

  newNganh(Nganh nganh) async{
    final db = await database;
    var res = await db.insert("NGANH", nganh.toMap());
    return res;
  }

  newSVTrongLop(CTLop ctlop) async{
    final db = await database;
    var res = await db.insert("CTLop", ctlop.toMap());
    return res;
  }

  Future<Lop> getLop(int malop) async{
    final db = await database;
    var res = await db.query("LOP", where: "malop= ?", whereArgs: [malop]);
    return res.isNotEmpty ? Lop.fromMap(res.first) : null;
  }

  Future<List<Lop>> getAllLop() async{
    final db = await database;
    var res = await db.query("LOP");
    List<Lop> lstLop = res.isNotEmpty ? res.map((item) => Lop.fromMap(item)).toList():[];
    return lstLop;
  }

  Future<List<Lop>> getLopTheoHocPhan(int mahp) async{
    final db = await database;
    var res = await db.query("LOP", where: "mahp=?", whereArgs: [mahp]);
    List<Lop> lstLop = res.isNotEmpty ? res.map((item) => Lop.fromMap(item)).toList():[];
    return lstLop;
  }

  Future<List<Nganh>> getAllNganh() async{
    final db = await database;

    var res = await db.query("NGANH");
    List<Nganh> lstNganh = res.isNotEmpty ? res.map((item) => Nganh.fromMap(item)).toList():[];
    return lstNganh;
  }


  Future<List<HocPhan>> getHocPhanTheoNganh(Nganh nganh) async{
    if (nganh == null)
      return [];
    final db = await database;

    var res = await db.rawQuery("select hocphan.mahp, tenhp from ctnganh inner join hocphan on ctnganh.mahp=hocphan.mahp where manganh=" + nganh.manganh.toString());
    List<HocPhan> lstHocPhan = res.isNotEmpty ? res.map((item) => HocPhan.fromMap(item)).toList():[];
    return lstHocPhan;
  }

  Future<SinhVien> getSinhVien(String mssv) async{
      final db = await database;
      var res = await db.query("SINHVIEN", where: "mssv= ?", whereArgs: [mssv]);
      return res.isNotEmpty ? SinhVien.fromMap(res.first) : null;
  }

  Future<List<SinhVien>> getSinhVienTheoLop(int malop) async{
    final db = await database;
    var res = await db.rawQuery("SELECT sv.* from CTLOP as ctl inner join SINHVIEN as sv on sv.mssv = ctl.mssv where malop=" + malop.toString());
    List<SinhVien> lstSinhVien = res.isNotEmpty ? res.map((item) => SinhVien.fromMap(item)).toList():[];
    return lstSinhVien;
  }

  Future<List<Lop>> getLopTheoSinhVien(String mssv) async{
    final db = await database;
    var res = await db.rawQuery("SELECT lop.malop, tenlop from CTLOP ctl inner join LOP lop on lop.malop = ctl.malop where mssv='"+mssv+"'");
    List<Lop> lstLop = res.isNotEmpty ? res.map((item) => Lop.fromMap(item)).toList():[];
    return lstLop;
  }

  Future<bool> getSinhVienTonTaiTrongLop(String mssv, int malop) async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM CTLOP where mssv='"+mssv+"' and malop="+malop.toString());
    return res.isNotEmpty;
  }

  deleteSVTrongLop(CTLop ctlop) async{
    final db = await database;
    var res = await db.delete("CTLop", where: "malop=? and mssv=?", whereArgs: [ctlop.malop, ctlop.mssv]);
    return res;
  }

  Future<HocPhan>getHocPhan(int mahp) async{
    final db = await database;
    var res = await db.query("HOCPHAN", where: "mahp=?", whereArgs: [mahp]);
    return res.isNotEmpty? HocPhan.fromMap(res.first) : null;
  }
}