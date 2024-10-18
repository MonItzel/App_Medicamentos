import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Agradecimiento extends StatelessWidget {
  const Agradecimiento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryBackground,
      appBar: AppBar(
        title: const Text(
          'Acerca de',
          style: AppStyles.encabezado1,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ProfilePage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Esta aplicación fue desarrollada por estudiantes de',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF0C2D56)),
            ),
            Container(
              height: 70,
              color: Color(0xFF0C2D56),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(children: [
                        Image.asset('assets/images/logo_facing.png'),
                        Positioned(
                          top: 30,
                          bottom: 0,
                          // Ajusta esta posición según lo que necesites
                          left: 43,
                          right: 0,
                          child: Text(
                            'Área de Ciencias de la Computación',
                            style: TextStyle(color: Colors.white, fontSize: 9),
                            //textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ),
                    // SizedBox(height: 10,),
                    VerticalDivider(
                      color: Colors.white, // Color del divisor
                      thickness: 2, // Grosor del divisor
                      width: 16, // Espacio horizontal alrededor del divisor
                    ),
                    Image.asset('assets/images/logo_uaslp.png'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Image.asset('assets/images/logos_institucion.png'),
                  Text(
                    'Equipo desarrollador:',
                    style: AppStyles.textoA,
                  ),
                  Text('Luis Eduardo Carreón Soto \n'
                      'Leonardo Ortega Chávez \n'
                      'José Ricardo Romero García \n'
                      'Mónica Itzel Tavera Hernández\n'
                      'Yessica Araceli Tellez Martínez'),

                  Text(
                    'Asesor de proyecto:',
                    style: AppStyles.textoA,
                  ),
                  Text(
                    'Dra. Sandra Edith Nava Muñoz',
                  ),
                  Text('Profesores:', style: AppStyles.textoA),
                  Text('Dr. Francisco Eduardo Martínez Pérez'),
                  Text('Dr. Francisco Edgar Castillo Barrera    '),
                  Text(
                    'Solicitante:',
                    style: AppStyles.textoA,
                  ),
                  Text('L.FT. Gabriela Castillo Muñoz'),

                  Text(
                    'Agradecimientos a:',
                    style: AppStyles.textoA,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainaxisaligment:Main
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          // Esto asegura que el texto se reduzca si es necesario.
                          child: Row(
                            children: [
                              Icon(Icons.brightness_1_rounded, size: 7),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Asociación de Profesionistas Especializados en la',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '   Atención del Adulto Mayor',
                          style: TextStyle(fontSize: 14),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          // Esto asegura que el texto se reduzca si es necesario.
                          child: Row(
                            children: [
                              Icon(Icons.brightness_1_rounded, size: 7),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Centro Potosino de Integración de la Tercera Edad',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ]),

                  SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/logos_asoci.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
