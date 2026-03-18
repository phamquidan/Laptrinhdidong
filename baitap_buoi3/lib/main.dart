import 'package:flutter/material.dart';
import 'bai01.dart';
import 'bai02.dart';
import 'bai03.dart';
import 'bai04.dart';
import 'bai05.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài tập Flutter',
      theme: ThemeData(useMaterial3: true),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn bài'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _btn(context, 'Bài 01 - Thông tin SV/GV', const Bai01()),
            const SizedBox(height: 10),
            _btn(context, 'Bài 02 - Thông tin đề tài', const Bai02()),
            const SizedBox(height: 10),
            _btn(context, 'Bài 03 - Thông tin sản phẩm', const Bai03()),
            const SizedBox(height: 10),
            _btn(context, 'Bài 04 - Thông tin nhóm', const Bai04()),
            const SizedBox(height: 10),
            _btn(context, 'Bài 05 - Giới thiệu CNTT & ATTT', const Bai05()),
          ],
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(text),
    );
  }
}
