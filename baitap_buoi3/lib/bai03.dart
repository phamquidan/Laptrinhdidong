import 'package:flutter/material.dart';

class Bai03 extends StatelessWidget {
  const Bai03({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 03 - Thông tin sản phẩm'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== 3 ẢNH SẢN PHẨM =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _productImage('assets/product1.jpg'),
                _productImage('assets/product2.jpg'),
                _productImage('assets/product3.jpg'),
              ],
            ),

            const SizedBox(height: 20),

            _line('Mã sản phẩm: ', 'SP001', Colors.red),
            _line('Tên sản phẩm: ', 'Tai nghe Bluetooth', Colors.blue),
            _line('Nhà sản xuất: ', 'Sony', Colors.red),
            _line('Giá bán: ', '450.000 VNĐ', Colors.green),
            _line(
              'Mô tả: ',
              'Âm thanh tốt, pin 8 giờ,\nkết nối ổn định, bảo hành 12 tháng.',
              Colors.blue,
            ),

            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Trở về'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị 1 ảnh
  Widget _productImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(path, width: 100, height: 100, fit: BoxFit.cover),
    );
  }

  // Dòng text có màu
  Widget _line(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
