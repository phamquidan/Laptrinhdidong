import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserStatusApp(),
  ));
}

class UserStatusApp extends StatelessWidget {
  const UserStatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700], // Nền xanh của nửa trên màn hình
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ==========================================
            // PHẦN HEADER MÀU XANH (NỬA TRÊN)
            // ==========================================
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Dòng chào hỏi và nút chuông
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, Huỳnh Đức!", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("23 Jan, 2021", style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.notifications, color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Thanh tìm kiếm
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 12),
                        Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Cảm xúc của bạn
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Are you ô kế?", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(Icons.more_horiz, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildEmojiFace("😞", "Bad"),
                      _buildEmojiFace("🙂", "Fine"),
                      _buildEmojiFace("😀", "Well"),
                      _buildEmojiFace("🥳", "Excellent"),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ==========================================
            // PHẦN BÀI TẬP MÀU TRẮNG (NỬA DƯỚI)
            // ==========================================
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exercises", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildExerciseTile(Icons.favorite, Colors.orange, "Speaking Skills", "10 Exercises"),
                          _buildExerciseTile(Icons.person, Colors.green, "Reading Skills", "8 Exercises"),
                          _buildExerciseTile(Icons.star, Colors.pink, "Writing Skills", "20 Exercises"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget hỗ trợ vẽ khuôn mặt cảm xúc
  Widget _buildEmojiFace(String emoji, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  // Widget hỗ trợ vẽ danh sách bài tập
  Widget _buildExerciseTile(IconData icon, Color color, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5)], // Đổ bóng nhẹ
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}