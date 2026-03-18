import 'package:flutter/material.dart';

class Bai05 extends StatelessWidget {
  const Bai05({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6), // nền sáng
        appBar: AppBar(
          title: const Text('Giới thiệu ngành học'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.computer), text: 'CNTT'),
              Tab(icon: Icon(Icons.security), text: 'ATTT'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _IntroPage(
              title: 'Ngành Công nghệ Thông tin (CNTT)',
              icon: Icons.computer,
              iconColor: Colors.blue,
              sections: [
                _Section(
                  'Giới thiệu',
                  'Ngành CNTT đào tạo kiến thức và kỹ năng về lập trình, phát triển phần mềm, '
                      'website, ứng dụng di động và hệ thống thông tin.',
                ),
                _Section(
                  'Mục tiêu đào tạo',
                  '- Nắm vững nền tảng lập trình và CSDL.\n'
                      '- Thiết kế, xây dựng phần mềm/app/web.\n'
                      '- Làm việc nhóm, phân tích và triển khai dự án.',
                ),
                _Section(
                  'Môn học tiêu biểu',
                  '- Nhập môn lập trình, OOP\n'
                      '- Cơ sở dữ liệu\n'
                      '- Lập trình Web\n'
                      '- Lập trình Mobile\n'
                      '- Công nghệ phần mềm',
                ),
                _Section(
                  'Cơ hội nghề nghiệp',
                  '- Lập trình viên (Web/Mobile)\n'
                      '- Tester/QC\n'
                      '- BA (Phân tích nghiệp vụ)\n'
                      '- Kỹ sư phần mềm / Quản trị hệ thống',
                ),
              ],
            ),
            _IntroPage(
              title: 'Ngành An toàn Thông tin (ATTT)',
              icon: Icons.security,
              iconColor: Colors.green,
              sections: [
                _Section(
                  'Giới thiệu',
                  'Ngành ATTT đào tạo kiến thức về bảo mật mạng, bảo vệ dữ liệu, '
                      'mã hóa và phòng chống tấn công trong môi trường số.',
                ),
                _Section(
                  'Mục tiêu đào tạo',
                  '- Hiểu và vận hành hệ thống mạng an toàn.\n'
                      '- Phát hiện, phân tích rủi ro bảo mật.\n'
                      '- Áp dụng mã hóa và các biện pháp bảo vệ dữ liệu.',
                ),
                _Section(
                  'Môn học tiêu biểu',
                  '- Mạng máy tính\n'
                      '- An toàn hệ điều hành\n'
                      '- Mật mã học\n'
                      '- An ninh mạng\n'
                      '- Pentest (cơ bản)',
                ),
                _Section(
                  'Cơ hội nghề nghiệp',
                  '- Chuyên viên an ninh mạng (Security)\n'
                      '- SOC Analyst\n'
                      '- Quản trị hệ thống/mạng\n'
                      '- Tư vấn/kiểm tra bảo mật',
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              child: const Text('Trở về', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<_Section> sections;

  const _IntroPage({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 6),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 50, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Khoa Công nghệ Thông tin - ĐH Công Thương TP.HCM',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 14),
          for (final s in sections) _SectionCard(section: s),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Section {
  final String title;
  final String content;
  const _Section(this.title, this.content);
}

class _SectionCard extends StatelessWidget {
  final _Section section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              section.content,
              style: const TextStyle(fontSize: 15, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}
