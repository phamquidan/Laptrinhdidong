import 'dart:io';

void main() {
  stdout.write("Nhập chuỗi: ");
  String s = stdin.readLineSync()!;

  print("Chuỗi vừa nhập: $s");

  // b. Đếm nguyên âm
  String nguyenAm = "aeiouAEIOU";
  int demNguyenAm = 0;
  for (int i = 0; i < s.length; i++) {
    if (nguyenAm.contains(s[i])) {
      demNguyenAm++;
    }
  }
  print("Số ký tự là nguyên âm: $demNguyenAm");

  // c. Đếm số từ
  List<String> tu = s.trim().split(RegExp(r'\s+'));
  print("Số từ trong chuỗi: ${tu.length}");

  // d. Kiểm tra đối xứng
  String sXuLy = s.replaceAll(" ", "").toLowerCase();
  String sNguoc = sXuLy.split('').reversed.join();
  print(
    sXuLy == sNguoc
        ? "Chuỗi là chuỗi đối xứng"
        : "Chuỗi không phải là chuỗi đối xứng",
  );

  // e. Đảo ngược từ
  print("Chuỗi sau khi đảo ngược từ: ${tu.reversed.join(" ")}");
}
