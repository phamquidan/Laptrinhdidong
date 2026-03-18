import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Ẩn chữ DEBUG góc phải
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Standard", style: TextStyle(color: Colors.black, fontSize: 22)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      // Tạo menu kéo từ bên trái (Drawer)
      drawer: Drawer(
        backgroundColor: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text("Calculator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ListTile(leading: Icon(Icons.calculate, color: Colors.blue), title: Text("Standard")),
            ListTile(leading: Icon(Icons.science), title: Text("Scientific")),
            ListTile(leading: Icon(Icons.show_chart), title: Text("Graphing")),
            ListTile(leading: Icon(Icons.code), title: Text("Programmer")),
            ListTile(leading: Icon(Icons.calendar_today), title: Text("Date calculation")),
          ],
        ),
      ),
      body: Column(
        children: [
          // Phần hiển thị số 0 to đùng
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: const Text(
                "0",
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Phần lưới các nút bấm
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _buildButtonRow(["MC", "MR", "M+", "M-", "MS", "M*"], isSmall: true),
                _buildButtonRow(["%", "CE", "C", "⌫"]),
                _buildButtonRow(["1/x", "x²", "√x", "÷"]),
                _buildButtonRow(["7", "8", "9", "×"]),
                _buildButtonRow(["4", "5", "6", "-"]),
                _buildButtonRow(["1", "2", "3", "+"]),
                _buildButtonRow(["+/-", "0", ".", "="], isEqualButton: true),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Hàm hỗ trợ vẽ từng hàng nút bấm cho ngắn gọn
  Widget _buildButtonRow(List<String> labels, {bool isSmall = false, bool isEqualButton = false}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: labels.map((label) {
          bool isEq = isEqualButton && label == "=";
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isEq ? Colors.blue[700] : (isSmall ? Colors.white : Colors.grey[100]),
                borderRadius: BorderRadius.circular(4),
              ),
              child: InkWell( // Tạo hiệu ứng bấm
                onTap: () {},
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: isSmall ? 14 : 22,
                      color: isEq ? Colors.white : Colors.black87,
                      fontWeight: isSmall ? FontWeight.normal : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}