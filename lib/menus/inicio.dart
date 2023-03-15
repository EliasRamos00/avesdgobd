import 'package:avesdgobd/paginas/splashscreen.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MiInicio();
  }
}

class MiInicio extends State<Inicio> {
  int _selectedIndex = 0;
  final List<Widget> _children = [SplashScreen(), SplashScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.blueGrey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Fotos'),
          BottomNavigationBarItem(icon: Icon(
              Icons.camera_alt_outlined
              ),
            label: 'Camera'
          )
        ],
      ),
    );
  }
}
