import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HuitFacilitiesApp(),
  ));
}

class HuitFacilitiesApp extends StatefulWidget {
  const HuitFacilitiesApp({super.key});

  @override
  State<HuitFacilitiesApp> createState() => _HuitFacilitiesAppState();
}

class _HuitFacilitiesAppState extends State<HuitFacilitiesApp> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static const List<Widget> _widgetOptions = <Widget>[
    Text('HOME PAGE', style: optionStyle),
    Text('COURSE PAGE', style: optionStyle),
    Text('CONTACT HUIT', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigationBar Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}