import 'package:app_medicamentos/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/pathologies.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/utils/button.dart';

class CarerPage extends StatefulWidget {
  const CarerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarerPage();
  }
}

class _CarerPage extends State <CarerPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro de cuidador',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => StartPage()
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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid
                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Nombre',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid

                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Apellido',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid

                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Número de teléfono',
            ),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 193,
              height: 77,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil <dynamic>(
                    context,
                    MaterialPageRoute <dynamic>(
                        builder: (BuildContext context) => HomePage()
                    ),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0063C9),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )
                ),
                child: Text("Siguiente",
                  style: TextStyle(
                      fontSize: 26
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        child: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {

            } else if (index == 1) {
              //Calendario
            } else if (index == 2) {
              muestraButtonSheet();
            } else if (index == 3) {
              //Registros
            } else if (index == 4) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }
          },
        ),
      ),
    );
  }
  void muestraButtonSheet(){
    final int bandShow = 0;
    // band: revisar que valor tiene para mostrar los widgets qe necesites
    //final bool num = 0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.0)
          )
      ),
      context: context,
      builder: (BuildContext context){
        return SizedBox(
            height: 350,
            child: Center(
              // child: bandShow == 1 ? Column(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (bandShow == 0)
                    Column(
                      children: [
                        Button(color: 0xFF0D1C52,
                          ancho: 263,
                          alto: 71,
                          contenido: 'Agregar medicamento',
                          ruta: 0,
                        ),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0D1C52,
                          ancho: 263,
                          alto: 71,
                          contenido: 'Agregar cita médica',
                          ruta: 1,
                        )
                      ],
                    ),

                  if (bandShow == 1)
                    Column(
                      children: [
                        Text('Medicamento agregado con éxito',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 2)
                    Column(
                      children: [
                        Text('Error al agregar medicamento',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 3)
                    Column(
                      children: [
                        Text('Cita agregada con éxito',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 4)
                    Column(
                      children: [
                        Text('Error al agregar cita',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    )
                ],
              ) ,
            )
        );
      },
    );
  }
}