import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/utils/button.dart';

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
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Fecha actual: $formattedDate',
            style: TextStyle(fontSize: 24),
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
              muestraButtonSheet();
              // Navega a la página de perfil
              // Por ejemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }
          },
        ),
      ),
    );
  }
  //  void muestraButtonSheet(BuildContext context, int bandShow, String text){PENDIENTE}

  void muestraButtonSheet(){
    // band: revisar que valor tiene para mostrar los widgets qe necesites
    //final bool num = 0;
    showModalBottomSheet(context: context,
      builder: (BuildContext context){
        return SizedBox(
            height: 350,
            child: Center(
              // child: bandShow == 1 ? Column(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //if(num = 0){
                  /* FUNCIONES*/
                  // const SizedBox(width: 0.0, height: 60.0,), YA NO SE UTILIZA
                  Button(color: 0xFF0D1C52,
                    ancho: 263,
                    alto: 60,
                    contenido: 'Agregar medicamento',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0D1C52,
                      ancho: 263,
                      alto: 60,
                      contenido: 'Agregar cita médica')


                  /* MEDICAMENTO AGREGADO
                 // const SizedBox(width: 0.0, height: 60.0,),
                  Texto(contenido: 'Medicamento agregado con éxito',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar'),
                  */

                  /*ERROR AL AGREGAR EL MEDICAMENTO
                  //const SizedBox(width: 0.0, height: 60.0,),
                  Texto(contenido: 'Error al agregar medicamento',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar'),
                  */


                  /* CITA AGREGADO
                  //const SizedBox(width: 0.0, height: 60.0,),
                  Texto(contenido: 'Cita agregada con éxito',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar'),
                  */




                  /*ERROR AL AGREGAR LA CITA
                  //const SizedBox(width: 0.0, height: 60.0,),
                  Texto(contenido: 'Error al agregar cita',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar'),
*/

                ],
              ) ,
            )
        );
      },
    );
  }
}
