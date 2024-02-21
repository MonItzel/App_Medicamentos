import 'package:flutter/material.dart';
import 'package:app_medicamentos/utils/buttonSheet.dart';
import 'package:app_medicamentos/constants.dart';

//Esta clase es para maquetar y retornar el navbar, permitiendo crear un navbar custom y que este se pueda utilizar en las vistas necesarias
class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final int bandShow = 0;

    //Se retorna el contenedor donde se encuentra el navbar
    //Se recibe el como parametro un numero entero que indica en que vista se encuentra el usuario para que el icono en el navbar se muestre de un color diferente
    return Container(
      color: AppStyles.primaryBlue,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.grey : Colors.white, size: 34),
            onPressed: () {
              onTap(0);
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_month, color: currentIndex == 1 ? Colors.grey : Colors.white, size: 34),
            onPressed: () {
              onTap(1);
            },
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppStyles.secondaryBlue,
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 36),
              onPressed: () {
                //onTap(2);
                muestraButtonSheet(context, bandShow);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_note, color: currentIndex == 3 ? Colors.grey : Colors.white, size: 34),
            onPressed: () {
              onTap(3);
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: currentIndex == 4 ? Colors.grey : Colors.white, size: 34),
            onPressed: () {
              onTap(4);
            },
          ),
        ],
      ),
    );
  }
  
}
