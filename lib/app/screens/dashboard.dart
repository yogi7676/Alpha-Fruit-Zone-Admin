import 'package:flutter/material.dart';
import 'package:foodbuddy/app/screens/home.dart';
import 'package:foodbuddy/app/screens/account.dart';
import 'package:foodbuddy/app/screens/vendors.dart';

class BottomIcons {
  String title;
  IconData icon;

  BottomIcons({required this.title, required this.icon});
}

List<BottomIcons> bottomList = [
  BottomIcons(title: 'Home', icon: Icons.home),
  BottomIcons(title: 'Dealers', icon: Icons.business),
  BottomIcons(title: 'Account', icon: Icons.account_circle),
];

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int navCurrentIndex = 0;
  static const viewWidgets = [
    Home(),
    Vendors(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alpha Fruit Zone'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: navCurrentIndex,
          onTap: (selIndex) {
            setState(() {
              navCurrentIndex = selIndex;
            });
          },
          type: BottomNavigationBarType.shifting,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            ...List.generate(
                bottomList.length,
                (index) => BottomNavigationBarItem(
                    icon: Icon(bottomList[index].icon),
                    label: bottomList[index].title))
          ]),
      body: viewWidgets[navCurrentIndex],
    );
  }
}
