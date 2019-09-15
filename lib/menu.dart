import 'package:flutter/material.dart';
import 'package:vtb_pay_app/design.dart';
import 'package:vtb_pay_app/history_page.dart';
import 'package:vtb_pay_app/invoice_page.dart';
import 'package:vtb_pay_app/profile_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    InvoicePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('Выставить счёт'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('История'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Профиль'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
