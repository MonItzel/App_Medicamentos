import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/utils/button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:page_transition/page_transition.dart';
import 'package:app_medicamentos/constants.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  State<StatefulWidget> createState() {
    return _CalendarPage();
  }
}

class _CalendarPage extends State<CalendarPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Calendario',
            style: AppStyles.encabezado1,
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Selecciona una fecha para ver los medicamentos y citas programados para el dia seleccionado',
                      style: AppStyles.texto3,
                    ),
                  ),
                ),

                SfDateRangePicker(
                  initialDisplayDate: widget.initialDate.year == DateTime.now().year &&
                      widget.initialDate.month == DateTime.now().month &&
                      widget.initialDate.day == DateTime.now().day ?
                  null : widget.initialDate,
                  initialSelectedDate: widget.initialDate.year == DateTime.now().year &&
                      widget.initialDate.month == DateTime.now().month &&
                      widget.initialDate.day == DateTime.now().day ?
                  null : widget.initialDate,
                  selectionMode: DateRangePickerSelectionMode.single,
                  showNavigationArrow: true,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    // Al seleccionar cualquier fecha, se generan las cartas correspondientes.
                    dateTime = args.value;
                    CreateCards(context, args.value.toString());
                  },
                  todayHighlightColor: AppStyles.secondaryBlue,
                  selectionColor: AppStyles.primaryBlue,
                ),
                const SizedBox(height: 20.0,),

                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Eventos para',
                      style: AppStyles.texto1,
                    ),
                  ),
                ),
              ]
                  // Se genera el calendario y debajo de él las cartas.
                    + calendarPageCards
            ),
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
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const HomePage(),
                ),
                    (route) => false,
              );
            } else if (index == 1) {
              // Pagina actual, no necesita navegacion
            } else if (index == 2) {
              muestraButtonSheet();
            } else if (index == 3) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const RecordsPage(),
                ),
                    (route) => false,
              );
            } else if (index == 4) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const ProfilePage(),
                ),
                    (route) => false,
              );
            }
          },
        ),
      ),
    );
  }

  void muestraButtonSheet() {
    final int bandShow = 0;
    // band: revisar que valor tiene para mostrar los widgets que necesites
    // final bool num = 0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 350,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (bandShow == 0)
                  Column(
                    children: [
                      Button(
                        color: 0xFF0D1C52,

                        contenido: 'Agregar medicamento',
                        ruta: 0,
                      ),
                      const SizedBox(width: 0.0, height: 60.0,),
                      Button(
                        color: 0xFF0D1C52,

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
                      Button(color: 0xFF0063C9, contenido: 'Aceptar', ruta: 2,),
                    ],
                  ),

                if (bandShow == 2)
                  Column(
                    children: [
                      Text('Error al agregar medicamento',),
                      const SizedBox(width: 0.0, height: 60.0,),
                      Button(color: 0xFF0063C9, contenido: 'Aceptar', ruta: 2,),
                    ],
                  ),

                if (bandShow == 3)
                  Column(
                    children: [
                      Text('Cita agregada con éxito',),
                      const SizedBox(width: 0.0, height: 60.0,),
                      Button(color: 0xFF0063C9, contenido: 'Aceptar', ruta: 2,),
                    ],
                  ),

                if (bandShow == 4)
                  Column(
                    children: [
                      Text('Error al agregar cita',),
                      const SizedBox(width: 0.0, height: 60.0,),
                      Button(color: 0xFF0063C9, contenido: 'Aceptar', ruta: 2,),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  // Genera las cartas con los recordatorios del día seleccionado y vuelve a generar esta pantalla con los datos.
  Future<void> CreateCards(var context, String date) async {
    try {
      // Elimina los elementos de la lista.
      calendarPageCards.clear();
      Database database = await openDatabase(
          Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

      // Selecciona la información de los recordatorios y medicamentos de la fecha seleccionada.
      final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
        "SELECT * FROM Medicamento AS M INNER JOIN Recordatorio AS R ON M.id_medicamento = R.id_medicamento WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%'",
      );
      print("SELECT * FROM Medicamento AS M INNER JOIN Recordatorio AS R ON M.id_medicamento = R.id_medicamento WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%' ORDER BY R.fecha_hora ASC");
      print("map: " + medicamentos.length.toString());

      //Si retorna al menos un medicamento, genera la carta con la su información y lo agrega a la lista.
      if(medicamentos.length > 0){
        for(int i = 0; i < medicamentos.length; i++){

          String horaOriginal = medicamentos[i]['fecha_hora'].toString().split(" ")[1].split(".")[0];
          // Analiza la hora original en un objeto DateTime
          DateTime horaDateTime = DateTime.parse("2022-01-01 $horaOriginal");

          Color color = Colors.red;
          if(horaDateTime.hour >= 6 && horaDateTime.hour < 12){
            color = Colors.orange.shade50;
          }else if(horaDateTime.hour >= 12 && horaDateTime.hour < 18){
            color = Colors.lightBlue.shade50;
          }else if(horaDateTime.hour <6 || horaDateTime.hour > 18){
            color = Colors.indigo.shade50;
          }
          calendarPageCards.add(Card(
            color: color,
            elevation: 3, // Elevación para dar profundidad al card
            margin: EdgeInsets.all(16), // Margen alrededor del card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Borde redondeado con radio de 15
            ),
            child: ListTile(
              leading: Icon(Icons.medication_liquid, size: 40), // Icono de medicina a la izquierda
              title: Text(
                medicamentos[i]['nombre'].toString(), //Nombre del medicamento
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hora: ' + medicamentos[i]['fecha_hora'].toString().split(" ")[1].split(".")[0]),
                  Text("Dosis: " + medicamentos[i]['dosis'].toString()), //Dosis del medicamento
                ],
              ),
              trailing: Text(
                "Inicio: " + medicamentos[i]['inicioToma'].toString().split(" ")[0], //Fecha de inicio
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          );
        }
      }

      // Selecciona la información de los recordatorios y citas de la fecha seleccionada.
      final List<Map<String, dynamic>> citas = await database.rawQuery(
        "SELECT * FROM Cita AS C INNER JOIN Recordatorio AS R ON C.id_cita = R.id_cita WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%' ORDER BY R.fecha_hora ASC",
      );
      print("map: " + citas.length.toString());
      print("cards: " + homePageCards.length.toString());

      // Si retorna al menos una cita, genera la carta con la su información y lo agrega a la lista.
      if (citas.length > 0) {
        for (int i = 0; i < citas.length; i++) {
          String horaOriginal = citas[i]['fecha_hora'].toString().split(" ")[1].split(".")[0];
          // Analiza la hora original en un objeto DateTime
          DateTime horaDateTime = DateTime.parse("2022-01-01 $horaOriginal");

          Color color = Colors.red;
          if(horaDateTime.hour >= 6 && horaDateTime.hour < 12){
            color = Colors.orange.shade50;
          }else if(horaDateTime.hour >= 12 && horaDateTime.hour < 18){
            color = Colors.lightBlue.shade50;
          }else if(horaDateTime.hour <6 || horaDateTime.hour > 18){
            color = Colors.indigo.shade50;
          }

          calendarPageCards.add(Card(
            color: color,
            elevation: 3,
            margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Borde redondeado con radio de 15
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ListTile(
                leading: Icon(Icons.medical_services, size: 44),
                // Icono de medicina a la izquierda
                title: Text(
                  //citas[i]['motivo'].toString(),
                  'Cita Médica',
                  //Titulo
                  style: AppStyles.tituloCard,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        citas[i]['ubicacion'].toString(),
                        style: AppStyles.dosisCard,
                    ),
                    Text(
                      citas[i]['telefono_medico'].toString().split(" ")[0], //Fecha de inicio
                      style: AppStyles.dosisCard,
                    ),
                  ],
                ),
                trailing: Text(
                  citas[i]['fecha_hora'].toString().split(" ")[1].split(".")[0],
                  style: AppStyles.dosisCard,
                ),
              ),
            ),
          )
          );
        }
      }

      // Una vez la lista está llena, genera de nuevo la pantalla con la lista llena.
      Navigator.pushAndRemoveUntil <dynamic>(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: CalendarPage(initialDate: dateTime,),
        ),
            (route) => false,
      );
      print("cards: " + calendarPageCards.length.toString());
    } catch (exception) {
      print(exception);
    }
  }
}

List<Widget> calendarPageCards = [];
String date = DateTime.now().toString().split(" ")[0];
DateTime dateTime = DateTime.now();
