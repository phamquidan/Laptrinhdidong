import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MusicApp()));

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("P L A Y L I S T", style: TextStyle(color: Colors.black54, fontSize: 14, letterSpacing: 2)),
        centerTitle: true,
        actions: const [Icon(Icons.menu, color: Colors.black), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Ảnh bìa Album
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey.shade500, blurRadius: 15, offset: const Offset(5, 5)), BoxShadow(color: Colors.white, blurRadius: 15, offset: const Offset(-5, -5))]
              ),
              child: const Center(child: Icon(Icons.music_note, size: 100, color: Colors.white)), // Chỗ này thay bằng Image.asset nếu bạn có ảnh
            ),
            const SizedBox(height: 30),
            // Tên bài hát và ca sĩ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kota The Friend", style: TextStyle(color: Colors.black54, fontSize: 16)),
                    Text("Birdie", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(Icons.favorite, color: Colors.red[400], size: 30)
              ],
            ),
            const SizedBox(height: 30),
            // Thanh thời gian & Tiến trình
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("0:00"),
                Icon(Icons.shuffle, color: Colors.black54),
                Icon(Icons.repeat, color: Colors.black54),
                Text("4:22"),
              ],
            ),
            const SizedBox(height: 10),
            Container(height: 6, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10))), // Thanh timeline
            const Spacer(),
            // Cụm nút Play
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNeuButton(Icons.skip_previous),
                _buildNeuButton(Icons.play_arrow, isLarge: true),
                _buildNeuButton(Icons.skip_next),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Nút bấm có hiệu ứng nổi (Neumorphism)
  Widget _buildNeuButton(IconData icon, {bool isLarge = false}) {
    double size = isLarge ? 80 : 60;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(isLarge ? 40 : 15),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade500, blurRadius: 15, offset: const Offset(5, 5)),
          const BoxShadow(color: Colors.white, blurRadius: 15, offset: const Offset(-5, -5))
        ],
      ),
      child: Icon(icon, size: isLarge ? 40 : 30, color: Colors.black54),
    );
  }
}