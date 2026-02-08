import 'package:flutter/material.dart';

class Bai04 extends StatelessWidget {
  const Bai04({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 04 - Thông tin nhóm'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(Icons.group, size: 90, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              'NHÓM THỰC HIỆN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 14),

            _line('Mã nhóm: ', 'N01', Colors.red),
            _line('Tên nhóm: ', 'Nhóm Flutter', Colors.blue),
            _line('Số lượng: ', '3 thành viên', Colors.red),
            const SizedBox(height: 12),

            _memberCard(
              title: 'Thành viên 1 (Nhóm trưởng)',
              mssv: '2001221001',
              name: 'Nguyễn Văn A',
              role: 'Nhóm trưởng',
            ),
            _memberCard(
              title: 'Thành viên 2',
              mssv: '2001221002',
              name: 'Trần Thị B',
              role: 'Thành viên',
            ),
            _memberCard(
              title: 'Thành viên 3',
              mssv: '2001221003',
              name: 'Lê Văn C',
              role: 'Thành viên',
            ),

            const Spacer(),
            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Text('Trở về'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(String label, String value, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(color: c, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: c, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _memberCard({
    required String title,
    required String mssv,
    required String name,
    required String role,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            _small('MSSV: ', mssv),
            _small('Họ tên: ', name),
            _small('Vai trò: ', role),
          ],
        ),
      ),
    );
  }

  Widget _small(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$label$value', style: const TextStyle(fontSize: 16)),
    );
  }
}
