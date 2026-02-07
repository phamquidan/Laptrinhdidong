import 'dart:io';

abstract class PhongThue {
  final String maPhong;
  final int soNguoi;
  final int soDien;
  final int soNuoc;

  PhongThue(this.maPhong, this.soNguoi, this.soDien, this.soNuoc);

  double tinhTien();

  @override
  String toString() {
    return 'Ma: $maPhong | SoNguoi: $soNguoi | SoDien: $soDien | SoNuoc: $soNuoc | Tien: ${tinhTien().toStringAsFixed(0)}';
  }
}

class PhongA extends PhongThue {
  final int soNguoiThan; // số lần người thân thăm ở lại qua đêm

  PhongA(
    super.maPhong,
    super.soNguoi,
    super.soDien,
    super.soNuoc,
    this.soNguoiThan,
  );

  @override
  double tinhTien() {
    // Tiền phòng = 1400 + 2*Số điện + 8*Số nước + 50*SoNguoithan
    return (1400 + 2 * soDien + 8 * soNuoc + 50 * soNguoiThan).toDouble();
  }

  @override
  String toString() {
    return 'Loai A | ${super.toString()} | SoNguoiThan: $soNguoiThan';
  }
}

class PhongB extends PhongThue {
  final int giatUi;
  final int soMay;

  PhongB(
    super.maPhong,
    super.soNguoi,
    super.soDien,
    super.soNuoc,
    this.giatUi,
    this.soMay,
  );

  @override
  double tinhTien() {
    return 2000 + 2 * soDien + 8 * soNuoc + giatUi * 5 + soMay * 100;
  }

  @override
  String toString() {
    return 'Loai B | ${super.toString()} | GiatUi: $giatUi | SoMay: $soMay';
  }
}

PhongThue parsePhong(String line) {
  final parts = line.trim().split('#');
  if (parts.length < 5) {
    throw FormatException('Dong khong hop le: $line');
  }

  final ma = parts[0];
  final soNguoi = int.parse(parts[1]);
  final soDien = int.parse(parts[2]);
  final soNuoc = int.parse(parts[3]);

  if (ma.startsWith('A')) {
    if (parts.length != 5) {
      throw FormatException('Phong A can 5 truong: $line');
    }
    final soNguoiThan = int.parse(parts[4]);
    return PhongA(ma, soNguoi, soDien, soNuoc, soNguoiThan);
  }

  if (ma.startsWith('B')) {
    if (parts.length != 6) {
      throw FormatException('Phong B can 6 truong: $line');
    }
    final giatUi = int.parse(parts[4]);
    final soMay = int.parse(parts[5]);
    return PhongB(ma, soNguoi, soDien, soNuoc, giatUi, soMay);
  }

  throw FormatException('Ma phong khong bat dau bang A/B: $line');
}

Future<void> main() async {
  final file = File('../phongthue.txt');

  if (!await file.exists()) {
    print('Khong tim thay file phongthue.txt');
    return;
  }

  final lines = await file.readAsLines();
  final dsPhong = <PhongThue>[];

  for (final line in lines) {
    if (line.trim().isEmpty) continue;
    dsPhong.add(parsePhong(line));
  }

  print('=== DANH SACH PHONG THUE ===');
  for (final p in dsPhong) {
    print(p);
  }

  print('\n=== PHONG CO SO NGUOI THUE > 2 ===');
  final nhieuNguoi = dsPhong.where((p) => p.soNguoi > 2).toList();
  for (final p in nhieuNguoi) {
    print(p);
  }
  final tongTien = dsPhong.fold<double>(0, (sum, p) => sum + p.tinhTien());
  print('\n=== TONG TIEN PHONG THU DUOC ===');
  print(tongTien.toStringAsFixed(0));
  dsPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  print('\n=== DANH SACH SAU KHI SAP XEP GIAM DAN THEO SO DIEN ===');
  for (final p in dsPhong) {
    print(p);
  }
  print('\n=== DANH SACH PHONG LOAI A ===');
  final dsA = dsPhong.whereType<PhongA>().toList();
  for (final p in dsA) {
    print(p);
  }
}
