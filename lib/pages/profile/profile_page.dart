import 'package:app_medicamentos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Perfil',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => HomePage()
                ),
                    (route) => false,
              );
            },
          ),
          actions: const [],
          backgroundColor: const Color(0xFFEDF2FA),
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(30.0), // Define el padding deseado
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Fecha de nacimiento',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Dirección',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Cuidador',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
    );
  }
}