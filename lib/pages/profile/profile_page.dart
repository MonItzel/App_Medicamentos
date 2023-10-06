import 'package:app_medicamentos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.nombre, required this.apellidoP, required this.apellidoM,
    required this.fechaNac,
    required this.calle,  required this.colonia, required this.numExterior,
    required this.patologia});

  final nombre;
  final apellidoP;
  final apellidoM;
  final fechaNac;
  final calle;
  final colonia;
  final numExterior;
  final patologia;

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    var user = [
      widget.nombre,
      widget.apellidoP,
      widget.apellidoM,
      widget.fechaNac.toString(),
      widget.calle,
      widget.colonia,
      widget.numExterior,
      widget.patologia,
    ];

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
                    builder: (BuildContext context) =>
                        HomePage(nombre: widget.nombre,
                          apellidoP: widget.apellidoP,
                          apellidoM: widget.apellidoM,
                          fechaNac: widget.fechaNac,
                          calle: widget.calle,
                          colonia: widget.colonia,
                          numExterior: widget.numExterior,
                          patologia: widget.patologia,)
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
              'Nombre: ' + user[0] + ' ' + user[1] + ' ' + user[2],
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Fecha de nacimiento: ' + user[3],
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Dirección: ' + user[4] + ', ' + user[6] + ', ' + user[5],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                HomePage(
                  nombre: widget.nombre,
                  apellidoP: widget.apellidoP,
                  apellidoM: widget.apellidoM,
                  fechaNac: widget.fechaNac,
                  calle: widget.calle,
                  colonia: widget.colonia,
                  numExterior: widget.numExterior,
                  patologia: widget.patologia,)));
          } else if (index == 1) {
            // Navega a la página de búsqueda
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfilePage(
              nombre: widget.nombre,
              apellidoP: widget.apellidoP,
              apellidoM: widget.apellidoM,
              fechaNac: widget.fechaNac,
              calle: widget.calle,
              colonia: widget.colonia,
              numExterior: widget.numExterior,
              patologia: widget.patologia,)));
          } else if (index == 2) {
            // Navega a la página de perfil
            // Por ejemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
    );
  }

  Future<void> select() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
   'SELECT TOP 1 * FROM Usuario',
    );
    final List<Map<String, dynamic>> map2 = await database.rawQuery(
      'SELECT TOP 1 * FROM Padecimiento',
    );

    var user = [
      map1[0]['nombre'],
      map1[0]['apellidoP'],
      map1[0]['apellidoM'],
      map1[0]['fechaNac'],
      map1[0]['calle'],
      map1[0]['club'],
      map1[0]['numero_exterior'],
      map2[0]['nombre_padecimiento'],
    ];
  }
}