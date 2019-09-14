import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
    static const String _title = 'Flutter Code Sample';

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: _title,
        home: MyStatefulWidget(),
      );
    }
  }

  class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
  }

  class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    TextField(
      decoration: InputDecoration(
          labelText: 'Введите общую сумму счёта',
        
      ),
    ),
  Text(
  'Смотрим историю',
  style: optionStyle,
  ),
  Text(
  'Чекаем профиль ',
  style: optionStyle,
  ),
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
  title: const Text('BottomNavigationBar Sample'),
  ),
  body: Center(
  child: _widgetOptions.elementAt(_selectedIndex),
  ),
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
  selectedItemColor: Colors.amber[800],
  onTap: _onItemTapped,
  ),
  );
  }
  }