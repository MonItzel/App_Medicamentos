import 'package:flutter/material.dart';

void muestraSnackBar(BuildContext context){
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
                          Text("Por favor, ingrese su(s) nombre(s)",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,)
                        ],
                      )
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
