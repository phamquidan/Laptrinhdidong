import 'dart:io';
import 'dart:math';

// Tạo danh sách n số ngẫu nhiên trong [5..100]
List<int> taoDanhSach(int n) {
  final rnd = Random();
  return List.generate(n, (_) => rnd.nextInt(96) + 5);
}

// a) In danh sách
void xuatDanhSach(List<int> a) {
  print("Danh sách:");
  print(a);
}

// b) Tính TBC các số lẻ (nếu không có thì báo)
void trungBinhCongSoLe(List<int> a) {
  int sum = 0;
  int count = 0;

  for (final x in a) {
    if (x % 2 != 0) {
      sum += x;
      count++;
    }
  }

  if (count == 0) {
    print("Danh sách không có số lẻ.");
  } else {
    double avg = sum / count;
    print("Trung bình cộng các số lẻ: $avg");
  }
}

// c) Kiểm tra đối xứng
bool laDoiXung(List<int> a) {
  for (int i = 0; i < a.length ~/ 2; i++) {
    if (a[i] != a[a.length - 1 - i]) return false;
  }
  return true;
}

// d) Kiểm tra có sắp xếp tăng dần hay không (cho phép bằng nhau)
bool laTangDan(List<int> a) {
  for (int i = 0; i < a.length - 1; i++) {
    if (a[i] > a[i + 1]) return false;
  }
  return true;
}

// e) Tìm phần tử lớn nhất
int phanTuLonNhat(List<int> a) {
  int mx = a[0];
  for (final x in a) {
    if (x > mx) mx = x;
  }
  return mx;
}

// f) Tìm số chẵn lớn nhất (nếu không có trả về null)
int? soChanLonNhat(List<int> a) {
  int? mxEven;
  for (final x in a) {
    if (x % 2 == 0) {
      if (mxEven == null || x > mxEven) mxEven = x;
    }
  }
  return mxEven;
}

// g) Nhập giá trị, tìm; nếu có thì xóa tất cả phần tử bằng nó
void timVaXoaGiaTri(List<int> a) {
  stdout.write("Nhập một giá trị cần tìm: ");
  final line = stdin.readLineSync();

  if (line == null || line.trim().isEmpty) {
    print("Giá trị nhập không hợp lệ.");
    return;
  }

  int value;
  try {
    value = int.parse(line.trim());
  } catch (_) {
    print("Giá trị nhập không hợp lệ (không phải số nguyên).");
    return;
  }

  if (!a.contains(value)) {
    print("Không tìm thấy.");
  } else {
    a.removeWhere((x) => x == value);
    print("Đã xóa tất cả phần tử bằng $value.");
    print("Danh sách sau khi xóa: $a");
  }
}

void main() {
  stdout.write("Nhập số lượng phần tử n: ");
  int n = int.parse(stdin.readLineSync()!);

  if (n <= 0) {
    print("n phải > 0");
    return;
  }

  List<int> list = taoDanhSach(n);

  // a
  xuatDanhSach(list);

  // b
  trungBinhCongSoLe(list);

  // c
  print(
    laDoiXung(list) ? "Danh sách là đối xứng." : "Danh sách không đối xứng.",
  );

  // d
  print(
    laTangDan(list)
        ? "Danh sách được sắp xếp tăng dần."
        : "Danh sách không được sắp xếp tăng dần.",
  );

  // e
  print("Phần tử lớn nhất: ${phanTuLonNhat(list)}");

  // f
  final maxEven = soChanLonNhat(list);
  if (maxEven == null) {
    print("Danh sách không có số chẵn.");
  } else {
    print("Số chẵn lớn nhất: $maxEven");
  }

  // g
  timVaXoaGiaTri(list);
}
