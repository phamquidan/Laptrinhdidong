import 'dart:io';
import 'dart:math';

class QuyDoiDiem {
  static String diemChu(double dtb) {
    if (dtb >= 8.5) return 'A';
    if (dtb >= 8.0) return 'B+';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 6.5) return 'C+';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 5.0) return 'D+';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }

  static double he4(double dtb) {
    // map theo điểm chữ ở trên
    final ch = diemChu(dtb);
    switch (ch) {
      case 'A':
        return 4.0;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.0;
      case 'C+':
        return 2.5;
      case 'C':
        return 2.0;
      case 'D+':
        return 1.5;
      case 'D':
        return 1.0;
      default:
        return 0.0; // F
    }
  }
}

// =================== Lớp cha ===================
abstract class MonHoc {
  final String ma;
  final String ten;
  final int tinChi;

  MonHoc(this.ma, this.ten, this.tinChi);

  double dtb(); // điểm trung bình (hệ 10)

  String diemChu() => QuyDoiDiem.diemChu(dtb());
  double he4() => QuyDoiDiem.he4(dtb());

  @override
  String toString() {
    return 'Ma: $ma | Ten: $ten | TinChi: $tinChi | DTB: ${dtb().toStringAsFixed(2)} | Chu: ${diemChu()} | He4: ${he4().toStringAsFixed(1)}';
  }
}

// =================== Lý thuyết ===================
class LyThuyet extends MonHoc {
  final double tieuLuan;
  final double cuoiKy;

  LyThuyet(super.ma, super.ten, super.tinChi, this.tieuLuan, this.cuoiKy);

  @override
  double dtb() => tieuLuan * 0.3 + cuoiKy * 0.7;

  @override
  String toString() =>
      'LT | ${super.toString()} | TL: ${tieuLuan.toStringAsFixed(1)} | CK: ${cuoiKy.toStringAsFixed(1)}';
}

// =================== Thực hành ===================
class ThucHanh extends MonHoc {
  final double kt1;
  final double kt2;
  final double kt3;

  ThucHanh(super.ma, super.ten, super.tinChi, this.kt1, this.kt2, this.kt3);

  @override
  double dtb() => (kt1 + kt2 + kt3) / 3.0;

  @override
  String toString() =>
      'TH | ${super.toString()} | KT: ${kt1.toStringAsFixed(1)}, ${kt2.toStringAsFixed(1)}, ${kt3.toStringAsFixed(1)}';
}

// =================== Đồ án ===================
class DoAn extends MonHoc {
  final double gvhd;
  final double gvpb;

  DoAn(super.ma, super.ten, super.tinChi, this.gvhd, this.gvpb);

  @override
  double dtb() => (gvhd + gvpb) / 2.0;

  @override
  String toString() =>
      'DA | ${super.toString()} | GVHD: ${gvhd.toStringAsFixed(1)} | GVPB: ${gvpb.toStringAsFixed(1)}';
}

// =================== Helpers nhập liệu ===================
String readNonEmpty(String prompt) {
  while (true) {
    stdout.write(prompt);
    final s = stdin.readLineSync();
    if (s != null && s.trim().isNotEmpty) return s.trim();
    print('Khong duoc de trong!');
  }
}

int readInt(String prompt, {int minValue = -999999}) {
  while (true) {
    final s = readNonEmpty(prompt);
    final v = int.tryParse(s);
    if (v != null && v >= minValue) return v;
    print('Nhap so nguyen hop le (>= $minValue)!');
  }
}

double readDouble(
  String prompt, {
  double minValue = 0.0,
  double maxValue = 10.0,
}) {
  while (true) {
    final s = readNonEmpty(prompt);
    final v = double.tryParse(s);
    if (v != null && v >= minValue && v <= maxValue) return v;
    print('Nhap so thuc hop le trong [$minValue..$maxValue]!');
  }
}

// =================== Parse dòng file ===================
MonHoc parseMonHoc(String line) {
  final parts = line.trim().split('#');
  if (parts.length < 4) {
    throw FormatException('Dong khong hop le: $line');
  }

  final type = parts[0];
  final ma = parts[1];
  final ten = parts[2];
  final tc = int.parse(parts[3]);

  switch (type) {
    case 'LT':
      // LT#ma#ten#tinchi#tieuluan#cuoiky  => 6 phần
      if (parts.length != 6) throw FormatException('LT can 6 truong: $line');
      final tl = double.parse(parts[4]);
      final ck = double.parse(parts[5]);
      return LyThuyet(ma, ten, tc, tl, ck);

    case 'TH':
      // TH#ma#ten#tinchi#kt1#kt2#kt3 => 7 phần
      if (parts.length != 7) throw FormatException('TH can 7 truong: $line');
      final kt1 = double.parse(parts[4]);
      final kt2 = double.parse(parts[5]);
      final kt3 = double.parse(parts[6]);
      return ThucHanh(ma, ten, tc, kt1, kt2, kt3);

    case 'DA':
      // DA#ma#ten#tinchi#gvhd#gvpb => 6 phần
      if (parts.length != 6) throw FormatException('DA can 6 truong: $line');
      final gvhd = double.parse(parts[4]);
      final gvpb = double.parse(parts[5]);
      return DoAn(ma, ten, tc, gvhd, gvpb);

    default:
      throw FormatException('Loai mon hoc khong hop le: $type');
  }
}

// =================== Các chức năng yêu cầu ===================
void inDanhSach(List<MonHoc> ds, {String title = 'DANH SACH MON HOC'}) {
  print('\n=== $title ===');
  if (ds.isEmpty) {
    print('(rong)');
    return;
  }
  for (final m in ds) {
    print(m);
  }
}

bool isSortedByTenTangDan(List<MonHoc> ds) {
  for (var i = 0; i < ds.length - 1; i++) {
    final a = ds[i].ten.toLowerCase();
    final b = ds[i + 1].ten.toLowerCase();
    if (a.compareTo(b) > 0) return false;
  }
  return true;
}

List<MonHoc> monTinChiMax(List<MonHoc> ds) {
  if (ds.isEmpty) return [];
  final maxTc = ds.map((e) => e.tinChi).reduce(max);
  return ds.where((e) => e.tinChi == maxTc).toList();
}

double tinChiTrungBinh(List<MonHoc> ds) {
  if (ds.isEmpty) return 0.0;
  final sum = ds.fold<int>(0, (s, e) => s + e.tinChi);
  return sum / ds.length;
}

// =================== Nhập từ bàn phím ===================
MonHoc nhap1MonHoc() {
  final loai = readNonEmpty('Nhap loai mon (LT/TH/DA): ').toUpperCase();
  final ma = readNonEmpty('Ma mon: ');
  final ten = readNonEmpty('Ten mon: ');
  final tc = readInt('So tin chi: ', minValue: 0);

  switch (loai) {
    case 'LT':
      final tl = readDouble('Diem tieu luan: ');
      final ck = readDouble('Diem cuoi ky: ');
      return LyThuyet(ma, ten, tc, tl, ck);
    case 'TH':
      final k1 = readDouble('Diem KT1: ');
      final k2 = readDouble('Diem KT2: ');
      final k3 = readDouble('Diem KT3: ');
      return ThucHanh(ma, ten, tc, k1, k2, k3);
    case 'DA':
      final gvhd = readDouble('Diem GVHD: ');
      final gvpb = readDouble('Diem GVPB: ');
      return DoAn(ma, ten, tc, gvhd, gvpb);
    default:
      print('Loai khong hop le, mac dinh tao LT (0 diem)!');
      return LyThuyet(ma, ten, tc, 0, 0);
  }
}

Future<List<MonHoc>> docFileMonHoc(String path) async {
  final file = File(path);
  if (!await file.exists()) return [];
  final lines = await file.readAsLines();
  final ds = <MonHoc>[];
  for (final line in lines) {
    if (line.trim().isEmpty) continue;
    ds.add(parseMonHoc(line));
  }
  return ds;
}

Future<void> main() async {
  final ds = <MonHoc>[];

  // 1) Nhập danh sách từ bàn phím
  final n = readInt('Nhap so luong mon hoc muon nhap: ', minValue: 0);
  for (var i = 0; i < n; i++) {
    print('\n--- Nhap mon thu ${i + 1} ---');
    ds.add(nhap1MonHoc());
  }

  // 2) Xuất danh sách vừa nhập
  inDanhSach(ds, title: 'DANH SACH VUA NHAP');

  // 3) Kiểm tra tăng dần theo tên
  print('\n=== KIEM TRA TANG DAN THEO TEN ===');
  print(
    isSortedByTenTangDan(ds)
        ? 'DS da duoc sap xep tang dan theo ten.'
        : 'DS CHUA sap xep tang dan theo ten.',
  );

  // 4) Sắp xếp tăng dần theo số tín chỉ
  ds.sort((a, b) => a.tinChi.compareTo(b.tinChi));
  inDanhSach(ds, title: 'SAP XEP TANG DAN THEO TIN CHI');

  // 5) Môn có số tín chỉ cao nhất
  final maxList = monTinChiMax(ds);
  inDanhSach(maxList, title: 'CAC MON CO TIN CHI CAO NHAT');

  // 6) Tìm theo tên, nếu không có thì thêm
  final tenCanTim = readNonEmpty('\nNhap TEN mon hoc can tim: ').toLowerCase();
  final found = ds.where((m) => m.ten.toLowerCase() == tenCanTim).toList();

  if (found.isEmpty) {
    print(
      'Khong tim thay "$tenCanTim". Nhap thong tin mon hoc de them vao CUOI danh sach:',
    );
    final monMoi = nhap1MonHoc();
    ds.add(monMoi);
    print('Da them: $monMoi');
  } else {
    print('Tim thay ${found.length} mon:');
    for (final m in found) {
      print(m);
    }
  }

  // 7) Đọc file monhoc.txt vào danh sách
  final dsFile = await docFileMonHoc('../monhoc.txt');
  if (dsFile.isEmpty) {
    print('\n=== DOC FILE monhoc.txt ===');
    print('Khong tim thay hoac file rong: monhoc.txt');
  } else {
    print('\n=== DOC FILE monhoc.txt THANH CONG ===');
    inDanhSach(dsFile, title: 'DANH SACH DOC TU FILE');
  }
  // 8) Tính số tín chỉ trung bình trong danh sách hiện tại
  print('\n=== TIN CHI TRUNG BINH (DS HIEN TAI) ===');
  print(tinChiTrungBinh(ds).toStringAsFixed(2));
}
