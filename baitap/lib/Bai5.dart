import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MedicalApp()));

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello,", style: TextStyle(fontSize: 18, color: Colors.black54)),
                      Text("Mitch Koko", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(radius: 25, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, color: Colors.white))
                ],
              ),
              const SizedBox(height: 20),
              // Thẻ màu hồng
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.pink[100], borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Container(height: 100, width: 80, decoration: BoxDecoration(color: Colors.pink[200], borderRadius: BorderRadius.circular(12))),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("How do you feel?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text("Fill out your medical card right now", style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple[400], 
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            onPressed: () {},
                            child: const Text("Get Started", style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Thanh tìm kiếm
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.deepPurple[100], borderRadius: BorderRadius.circular(16)),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Text("How can we help you?", style: TextStyle(color: Colors.deepPurple)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Nút chuyên khoa
              Row(
                children: [
                  Expanded(child: _buildCategoryBtn(Icons.medical_services, "Dentist")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildCategoryBtn(Icons.person, "Surgeon")),
                ],
              ),
              const SizedBox(height: 30),
              // Danh sách bác sĩ
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Doctor list", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("See all", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              // Nơi cuộn ngang danh sách bác sĩ
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDoctorCard("Dr. Mitch Koko", "Psychologist", "4.4"),
                    _buildDoctorCard("Dr. Steve Jobs", "Surgeon", "5.0"),
                    _buildDoctorCard("Dr. Elon Musk", "Cardiologist", "4.8"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Hàm tạo nút Chuyên khoa
  Widget _buildCategoryBtn(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  // Hàm tạo thẻ Bác sĩ
  Widget _buildDoctorCard(String name, String job, String rating) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.deepPurple[100], borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const CircleAvatar(radius: 40, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, color: Colors.white, size: 40)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text(" $rating", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
          Text(job, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}