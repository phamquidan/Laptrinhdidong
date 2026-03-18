import 'package:flutter/material.dart';

class Bai01 extends StatelessWidget {
  const Bai01({super.key});

  @override
  Widget build(BuildContext context) {
    return const StudentPage();
  }
}

/// =======================
/// MÀN HÌNH SINH VIÊN
/// =======================
class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sinh viên'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.school),
            tooltip: 'Giảng viên',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TeacherPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/student.jpg'),
              ),

              const SizedBox(height: 18),

              const Text(
                'Họ và tên: Nguyễn Văn A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 10),

              _infoLine('MSSV: 2001221234'),
              _infoLine('Lớp: 13DHTH02'),
              _infoLine('Khóa: 13 Đại học'),
              _infoLine('Ngành: Công nghệ thông tin'),
              _infoLine('Trường: Đại học Công Thương\nTP. Hồ Chí Minh'),

              const SizedBox(height: 30),

              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Trở về', style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
    );
  }
}

/// =======================
/// MÀN HÌNH GIẢNG VIÊN
/// =======================
class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sinh viên'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/teacher.png'),
                backgroundColor: Colors.transparent,
              ),

              const SizedBox(height: 18),

              const Text(
                'Giảng viên Trần Thị A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 10),

              _infoLine('Khoa: Công nghệ Thông tin'),
              _infoLine('Học hàm: Thạc sĩ'),
              _infoLine('Chuyên ngành: CNPM'),
              _infoLine(
                'Giảng dạy:\nNhập môn lập trình\nLập trình Windows\nLập trình Web',
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Trở về', style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
    );
  }
}
