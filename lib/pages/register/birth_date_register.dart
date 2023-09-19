import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class BirthRegister extends StatefulWidget {
  const BirthRegister({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BirthRegister();
  }
}

class _BirthRegister extends State<BirthRegister> {
  // Inicializa una fecha seleccionada con la fecha actual.
  DateTime selectedDate = DateTime.now();
  // Inicializa un año seleccionado con el año actual.
  int selectedYear = DateTime.now().year;

  // Función para mostrar el selector de fecha.
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),  // Establece la fecha mínima (1900 en este caso).
      maxTime: DateTime.now(),  // Establece la fecha máxima (fecha actual).
      onChanged: (date) {
        // Se ejecuta cuando cambia la fecha seleccionada.
        setState(() {
          selectedDate = date;
        });
      },
      onConfirm: (date) {
        // Se ejecuta cuando se confirma la fecha seleccionada.
        setState(() {
          selectedDate = date;
          selectedYear = date.year;
        });
      },
      currentTime: selectedDate,  // Establece la fecha actual como valor inicial.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selector de Fecha de Nacimiento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Año de Nacimiento: $selectedYear',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Fecha de Nacimiento: ${selectedDate.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDatePicker,
              child: Text('Seleccionar Fecha de Nacimiento'),
            ),
          ],
        ),
      ),
    );
  }
}
