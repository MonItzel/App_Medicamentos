import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Home Page'),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Actualiza el índice seleccionado
            });
            // Realiza la navegación aquí según el índice
            if (index == 0) {
              // Navega a la página de inicio
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            } else if (index == 1) {
              // Navega a la página de búsqueda
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            } else if (index == 2) {
              // Navega a la página de perfil
              // Por ejemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }
          },
        ),
      ),
    );
  }
}
