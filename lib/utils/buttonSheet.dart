import 'package:flutter/material.dart';
import 'package:app_medicamentos/utils/button.dart';
import 'package:app_medicamentos/utils/texto.dart';
import 'package:app_medicamentos/constants.dart';

void muestraButtonSheet(BuildContext context, int bandShow){
  //final int bandShow = 0;
  // band: revisar que valor tiene para mostrar los widgets qe necesites
  //final bool num = 0;
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0)
        )
    ),

    context: context,
    builder: (BuildContext context){
      return SizedBox(
          height: 300,
          child: Center(
            // child: bandShow == 1 ? Column(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //Menu para agregar medicamento o cita medica
                if (bandShow == 0)
                  const Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          child: Text(
                            'Agregar',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      Button(
                        color: 0xFF0063C9,
                        contenido: 'Medicamento',
                        ruta: 0,
                      ),

                      SizedBox(
                        height: 40
                      ),

                      Button(
                        color: 0xFF0A3461,
                        contenido: 'Cita médica',
                        ruta: 1,
                      )
                    ],
                  ),


                //Notificacion de medicamento agregado correctamente
                if (bandShow == 1)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Medicamento agregado',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_ok.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 2,
                      ),
                    ],
                  ),


                //Notificacion de medicamento no agregado
                if (bandShow == 2)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al agregar medicamento',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 2,
                      ),
                    ],
                  ),


                //Notificacion de cita medica agregada correctamente
                if (bandShow == 3)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Cita médica agregada',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_ok.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 2,
                      ),
                    ],
                  ),


                //Notificacion de error al agregar una cita medica
                if (bandShow == 4)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al agregar cita',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 2,
                      ),
                    ],
                  ),


                //Notificacion de actualizacion de medicamento exitosa
                if (bandShow == 5)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Medicamento actualizado',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_ok.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de medicamento eliminado exitosamente
                if (bandShow == 6)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            '¿Desea eliminar el Medicamento?',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),


                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 4,
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Cancelar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de error al eliminar medicamento
                if (bandShow == 7)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al eliminar medicamento',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de cita eliminada con exito
                if (bandShow == 8)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Cita médica eliminada',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 5,
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Cancelar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de error al eliminar una cita medica
                if (bandShow == 9)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al actualizar cita',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de actualizacion de cita medica exitosa
                if (bandShow == 10)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Cita médica actualizada',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_ok.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de error al actualizar cita medica
                if (bandShow == 11)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al actualizar cita',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),


                //Notificacion de error al actualizar medicamento
                if (bandShow == 12)
                  Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 30, bottom: 16),
                          child:Text(
                            'Error al actualizar medicamento',
                            style: AppStyles.encabezado1,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30.0,
                      ),

                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                            child: Container(
                              child: Image.asset('assets/images/icon_error.png'),
                            ),
                          ),
                        ),
                      ),

                      const Button(
                        color: 0xFF0063C9,
                        contenido: 'Aceptar',
                        ruta: 3,
                      ),
                    ],
                  ),

              ],
            ),
          )
      );
    },

  );
}