import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Contenido de la página'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF446CF9),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.home,
              color: Colors.white
              ),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: Colors.white),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded,
                  color: Colors.white),
              label: 'Perfil',
            ),
          ],
          onTap: null, // Establece onTap en null para deshabilitar la navegación
        ),
      ),
    );
  }
}
