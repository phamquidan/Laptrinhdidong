import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: WalletApp()));

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("My Cards", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.add_circle_outline, color: Colors.black, size: 30), onPressed: () {})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Thẻ tín dụng màu tím
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.deepPurple[400], borderRadius: BorderRadius.circular(20)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Balance", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 10),
                  Text("\$5250.25", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("12345678", style: TextStyle(color: Colors.white70)),
                      Text("10/24", style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            // 3 Nút chức năng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.send, "Send"),
                _buildActionButton(Icons.credit_card, "Pay"),
                _buildActionButton(Icons.receipt, "Bills"),
              ],
            ),
            const SizedBox(height: 30),
            // Danh sách thống kê
            _buildListTile(Icons.bar_chart, Colors.blue, "Statistics", "Payment and Income"),
            _buildListTile(Icons.swap_horiz, Colors.green, "Transactions", "Transaction history"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {},
        child: const Icon(Icons.attach_money),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, size: 30, color: Colors.blue[700]),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))
      ],
    );
  }

  Widget _buildListTile(IconData icon, Color color, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}