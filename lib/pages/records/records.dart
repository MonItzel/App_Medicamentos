import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/utils/button.dart';


class RecordsPage extends StatefulWidget{
  const RecordsPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _RecordsPage();
  }
}

class _RecordsPage extends State <RecordsPage>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registros',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Text(
        'Aún no hay registros de citas ni medicamentos',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF6A6A6A),
          fontSize: 22,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
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
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //if(num = 0){
                  /* FUNCIONES*/
                  // const SizedBox(width: 0.0, height: 60.0,), YA NO SE UTILIZA
                  /*
                  Button(color: 0xFF0D1C52,
                    ancho: 263,
                    alto: 71,
                    contenido: 'Agregar medicamento',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0D1C52,
                      ancho: 263,
                      alto: 71,
                      contenido: 'Agregar cita médica')
*/

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


                  /* CITA AGREGADO*/
                  //const SizedBox(width: 0.0, height: 60.0,),
                  Text('Cita agregada con éxito',),
                  const SizedBox(width: 0.0, height: 60.0,),
                  Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar'),





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