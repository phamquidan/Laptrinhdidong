import 'package:flutter/material.dart';

class Bai02 extends StatelessWidget {
  const Bai02({super.key});

  @override
  Widget build(BuildContext context) {
    const titleColor = Colors.blue;
    const red = Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 02 - Thông tin đề tài'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.description, size: 90, color: Colors.blue),
            ),
            const SizedBox(height: 12),
            const Text(
              'ĐỀ TÀI ĐỒ ÁN / KHÓA LUẬN',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 14),
            _line('Mã đề tài: ', 'DT001', red),
            _line('Tên đề tài: ', 'Ứng dụng quản lý sinh viên', red),
            _line('Số SV tối đa: ', '3', red),
            _line('Chuyên ngành: ', 'CNPM', Colors.green),
            _line('GV hướng dẫn: ', 'ThS. Trần Thị A', Colors.blue),
            _line(
              'Yêu cầu: ',
              'Flutter + Firebase.\nCó đăng nhập, CRUD dữ liệu, báo cáo.',
              Colors.blue,
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 170,
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
