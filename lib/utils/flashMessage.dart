import 'package:app_medicamentos/utils/TextSnackBar.dart';
import 'package:flutter/material.dart';

void muestraSnackBar(BuildContext context, int bandShow){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const SizedBox(width: 25,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Advertencia', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),),
                          Spacer(),
                          if(bandShow == 0)
                           TextoSnackBar(contenido: 'Por favor ingrese su(s) nombres', tamFontSize: 25),
                         if(bandShow == 1)
                          TextoSnackBar(contenido: 'Puede ingresar su(s) apellido(s) paterno y/o materno', tamFontSize: 19),
                          if(bandShow == 2)
                            TextoSnackBar(contenido: 'Por favor, ingrese la hora de toma de su medicamento', tamFontSize: 22),
                          if(bandShow == 3)
                            TextoSnackBar(contenido: 'Por favor ingrese el nombre de la patología', tamFontSize: 25),
                          ]
                      ),

                  )
                ],
              ),
              height: 115,
              decoration: BoxDecoration(
                  color: Colors.redAccent[400],
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
            Positioned(
              left: -12,
              top: -15,
              child: Icon(
                Icons.circle,
                size: 45,
                color: Colors.redAccent[400],
              ),
            ),

            Positioned(
                left: -12,
                top: -15,
                child: Icon(
                  Icons.error,
                  size: 45,
                  color: Colors.white,
                )
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
  );
}
