import 'package:flutter/material.dart';
import 'package:app_medicamentos/utils/button.dart';
import 'package:app_medicamentos/utils/texto.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0063C9), // Cambia el color de fondo
      height: 55, // Ajusta la altura del contenedor para hacer la barra de navegación más grande
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.grey : Colors.white, size: 32),
            onPressed: () {
              onTap(0);
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_month, color: currentIndex == 1 ? Colors.grey : Colors.white, size: 32),
            onPressed: () {
              onTap(1);
            },
          ),
          Container(
            width: 60, // Ancho del botón central
            height: 60, // Alto del botón central
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF09184D),// Cambia el color del fondo circular
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 32), // Ajusta el tamaño y color del icono "+"
              onPressed: () {
                //onTap(2);
                muestraButtonSheet(context);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_note, color: currentIndex == 3 ? Colors.grey : Colors.white, size: 32),
            onPressed: () {
              onTap(3);
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: currentIndex == 4 ? Colors.grey : Colors.white, size: 32),
            onPressed: () {
              onTap(4);
            },
          ),
        ],
      ),
    );
  }
  void muestraButtonSheet(BuildContext context){
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
                        Texto(contenido: 'Medicamento agregado con éxito',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 2)
                    Column(
                      children: [
                        Texto(contenido: 'Error al agregar medicamento',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 3)
                    Column(
                      children: [
                        Texto(contenido: 'Cita agregada con éxito',),
                        const SizedBox(width: 0.0, height: 60.0,),
                        Button(color: 0xFF0063C9, ancho: 180, alto: 60, contenido: 'Aceptar', ruta: 2,),
                      ],
                    ),

                  if (bandShow == 4)
                    Column(
                      children: [
                        Texto(contenido: 'Error al agregar cita',),
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
