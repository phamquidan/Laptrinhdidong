import 'dart:io';
import 'dart:math';

// ===================== Helpers nhập =====================
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

double readDouble(String prompt, {double minValue = 0.0}) {
  while (true) {
    final s = readNonEmpty(prompt);
    final v = double.tryParse(s);
    if (v != null && v > minValue) return v;
    print('Nhap so thuc hop le (> $minValue)!');
  }
}

// ===================== Base invoice =====================
abstract class HoaDon {
  String _maKH = 'KH0000';
  String _tenKH = 'Unknown';
  int _soLuong = 1;
  double _giaBan = 1.0;

  // Default constructor
  HoaDon();

  // Named constructor full params
  HoaDon.full(String maKH, String tenKH, int soLuong, double giaBan) {
    setMaKH(maKH);
    setTenKH(tenKH);
    setSoLuong(soLuong);
    setGiaBan(giaBan);
  }

  // ===== Validators / setters =====
  void setMaKH(String ma) {
    final reg = RegExp(r'^KH\d{4}$');
    if (!reg.hasMatch(ma)) {
      throw FormatException('Ma KH sai dinh dang (KH0000): $ma');
    }
    _maKH = ma;
  }

  void setTenKH(String ten) {
    if (ten.trim().isEmpty) throw FormatException('Ten KH khong duoc de trong');
    _tenKH = ten.trim();
  }

  void setSoLuong(int sl) {
    if (sl <= 0) throw FormatException('So luong phai > 0');
    _soLuong = sl;
  }

  void setGiaBan(double gia) {
    if (gia <= 0) throw FormatException('Gia ban phai > 0');
    _giaBan = gia;
  }

  String get maKH => _maKH;
  String get tenKH => _tenKH;
  int get soLuong => _soLuong;
  double get giaBan => _giaBan;

  double get tienHang => soLuong * giaBan;
  double get vat => tienHang * 0.10;

  // Chiết khấu (số tiền)
  double chietKhau();

  // Trợ giá / hỗ trợ / giảm giá thêm (số tiền)
  double troGia();

  double thanhTien() {
    // Thành tiền = Tiền hàng - Chiết khấu + VAT - Trợ giá
    return tienHang - chietKhau() + vat - troGia();
  }

  // ===== Nhập / Xuất =====
  void nhapChung() {
    while (true) {
      try {
        final ma = readNonEmpty('Ma KH (KH0000): ');
        setMaKH(ma);
        break;
      } catch (e) {
        print('Loi: $e');
      }
    }
    while (true) {
      try {
        final ten = readNonEmpty('Ten KH: ');
        setTenKH(ten);
        break;
      } catch (e) {
        print('Loi: $e');
      }
    }
    while (true) {
      try {
        final sl = readInt('So luong: ', minValue: 1);
        setSoLuong(sl);
        break;
      } catch (e) {
        print('Loi: $e');
      }
    }
    while (true) {
      try {
        final gia = readDouble('Gia ban: ', minValue: 0.0);
        setGiaBan(gia);
        break;
      } catch (e) {
        print('Loi: $e');
      }
    }
  }

  void nhap(); // mỗi loại nhập thêm

  String loai();

  @override
  String toString() {
    return 'Loai: ${loai()} | MaKH: $maKH | Ten: $tenKH | SL: $soLuong | Gia: ${giaBan.toStringAsFixed(0)}'
        ' | TienHang: ${tienHang.toStringAsFixed(0)} | CK: ${chietKhau().toStringAsFixed(0)} | VAT: ${vat.toStringAsFixed(0)}'
        ' | TroGia: ${troGia().toStringAsFixed(0)} | ThanhTien: ${thanhTien().toStringAsFixed(0)}';
  }
}

// ===================== Cá nhân =====================
class HoaDonCaNhan extends HoaDon {
  double khoangCachKm;

  HoaDonCaNhan() : khoangCachKm = 0, super();

  HoaDonCaNhan.full(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this.khoangCachKm,
  ) : super.full(maKH, tenKH, soLuong, giaBan);

  @override
  String loai() => 'CaNhan';

  @override
  void nhap() {
    nhapChung();
    khoangCachKm = readDouble(
      'Khoang cach giao hang (km): ',
      minValue: -0.0001,
    );
  }

  @override
  double chietKhau() {
    // Nếu sl < 3 => 0
    if (soLuong < 3) return 0.0;

    // chiết khấu 5% đơn giá trên từng sp => 0.05 * gia * sl
    var ck = giaBan * 0.05 * soLuong;

    // nếu khoảng cách < 10km => thêm 50.000 trên mỗi sp
    if (khoangCachKm < 10) ck += 50000.0 * soLuong;

    return ck;
  }

  @override
  double troGia() {
    // trợ giá: mỗi sp = 2% giá bán
    var tg = giaBan * 0.02 * soLuong;

    // nếu sl > 2 hỗ trợ thêm 100.000 (một lần)
    if (soLuong > 2) tg += 100000.0;

    return tg;
  }
}

// ===================== Đại lý cấp 1 =====================
class HoaDonDaiLyCap1 extends HoaDon {
  int namHopTac = 0;

  HoaDonDaiLyCap1() : super();

  @override
  String loai() => 'DaiLyCap1';

  @override
  void nhap() {
    nhapChung();
    namHopTac = readInt('So nam hop tac: ', minValue: 0);
  }

  double _tyLeCK() {
    // luôn 30%
    var rate = 0.30;

    // nếu > 5 năm => thêm 1% mỗi năm, tối đa 35%
    if (namHopTac > 5) {
      rate += (namHopTac - 5) * 0.01;
      rate = min(rate, 0.35);
    }
    return rate;
  }

  @override
  double chietKhau() => tienHang * _tyLeCK();

  @override
  double troGia() => 0.0; // không nêu trợ giá cho đại lý
}

// ===================== Khách hàng công ty =====================
class HoaDonCongTy extends HoaDon {
  int soNhanVien = 0;

  HoaDonCongTy() : super();

  @override
  String loai() => 'CongTy';

  @override
  void nhap() {
    nhapChung();
    soNhanVien = readInt('So nhan vien: ', minValue: 0);
  }

  double _tyLeCK() {
    // > 5000 => 7%, else if > 1000 => 5%, else 0
    if (soNhanVien > 5000) return 0.07;
    if (soNhanVien > 1000) return 0.05;
    return 0.0;
  }

  @override
  double chietKhau() => tienHang * _tyLeCK();

  @override
  double troGia() {
    // mỗi sp giảm 120.000
    return 120000.0 * soLuong;
  }
}

// ===================== Quản lý hóa đơn =====================
class QuanLyHoaDon {
  final List<HoaDon> ds = [];

  void nhapDanhSach() {
    final n = readInt('Nhap so luong hoa don: ', minValue: 0);
    for (var i = 0; i < n; i++) {
      print('\n--- Nhap hoa don thu ${i + 1} ---');
      final type = readNonEmpty('Chon loai (1-CaNhan, 2-DaiLy1, 3-CongTy): ');
      late HoaDon hd;
      if (type == '1')
        hd = HoaDonCaNhan();
      else if (type == '2')
        hd = HoaDonDaiLyCap1();
      else
        hd = HoaDonCongTy();

      hd.nhap();
      ds.add(hd);
    }
  }

  void xuatDanhSach() {
    print('\n=== DANH SACH HOA DON ===');
    if (ds.isEmpty) {
      print('(rong)');
      return;
    }
    for (final hd in ds) {
      print(hd);
    }
  }

  double tongThanhTien() => ds.fold<double>(0.0, (s, e) => s + e.thanhTien());

  double tongTroGia() => ds.fold<double>(0.0, (s, e) => s + e.troGia());

  HoaDon? hoaDonSoLuongMax() {
    if (ds.isEmpty) return null;
    var maxHd = ds.first;
    for (final hd in ds.skip(1)) {
      if (hd.soLuong > maxHd.soLuong) maxHd = hd;
    }
    return maxHd;
  }

  double tongChietKhauCongTy() {
    return ds.whereType<HoaDonCongTy>().fold<double>(
      0.0,
      (s, e) => s + e.chietKhau(),
    );
  }

  void sapXep() {
    ds.sort((a, b) {
      // tăng dần theo số lượng
      final c = a.soLuong.compareTo(b.soLuong);
      if (c != 0) return c;
      // nếu bằng nhau: giảm dần theo thành tiền
      return b.thanhTien().compareTo(a.thanhTien());
    });
  }

  void xuatTheoMa(String ma) {
    final found = ds.where((e) => e.maKH == ma).toList();
    if (found.isEmpty) {
      print('Khach hang la');
      return;
    }
    print('\n=== HOA DON CUA $ma ===');
    for (final hd in found) {
      print(hd);
    }
  }
}

// ===================== Main menu =====================
Future<void> main() async {
  final ql = QuanLyHoaDon();

  while (true) {
    print('''
\n========= MENU =========
1. Nhap danh sach hoa don
2. Xuat danh sach hoa don
3. Tong thanh tien tat ca hoa don
4. Tong tien tro gia
5. Khach hang mua nhieu nhat (so luong max)
6. Tong tien chiet khau doi voi KH cong ty
7. Sap xep (SL tang dan, neu bang nhau TT giam dan)
8. Xuat hoa don theo ma KH
0. Thoat
========================
''');

    final chon = readNonEmpty('Chon: ');
    switch (chon) {
      case '1':
        ql.nhapDanhSach();
        break;
      case '2':
        ql.xuatDanhSach();
        break;
      case '3':
        print('Tong thanh tien: ${ql.tongThanhTien().toStringAsFixed(0)}');
        break;
      case '4':
        print('Tong tro gia: ${ql.tongTroGia().toStringAsFixed(0)}');
        break;
      case '5':
        final hd = ql.hoaDonSoLuongMax();
        if (hd == null)
          print('Danh sach rong');
        else
          print('Hoa don co so luong max:\n$hd');
        break;
      case '6':
        print(
          'Tong chiet khau (KH cong ty): ${ql.tongChietKhauCongTy().toStringAsFixed(0)}',
        );
        break;
      case '7':
        ql.sapXep();
        print('Da sap xep!');
        break;
      case '8':
        final ma = readNonEmpty('Nhap ma KH (KH0000): ');
        ql.xuatTheoMa(ma);
        break;
      case '0':
        print('Bye!');
        return;
      default:
        print('Lua chon khong hop le!');
    }
  }
}
