import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/utils/button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:page_transition/page_transition.dart';

class RecordsPage extends StatefulWidget{
  const RecordsPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _RecordsPage();
  }
}

class _RecordsPage extends State <RecordsPage>{
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context){
    CreateCards(context);

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

      body: Container(
          height: recordsPageCards.length * 120, // Establece la altura del Container a 200 píxeles
          child: new ListView(
            children: recordsPageCards,
          )
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
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CalendarPage(),
                ),
                    (route) => false,
              );
            } else if (index == 2) {
              muestraButtonSheet();
            } else if (index == 3) {
              //Pagina actual, no necesita navegacion
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


  Future<void> CreateCards(var context) async {
    try{
      if(recordsPageCards.length < 1){
        Database database = await openDatabase(
            Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
          "SELECT * FROM Medicamento",
        );

        if(medicamentos.length > 0){
          for(int i = 0; i < medicamentos.length; i++){
            recordsPageCards.add(Card(
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
                    Text('Cada ' + medicamentos[i]['frecuenciaToma'].toString() + ' ' + medicamentos[i]['frecuenciaTipo'].toString() + 's'),
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

        print("medicamentos: " + medicamentos.length.toString());
        print("cards: " + recordsPageCards.length.toString());


        final List<Map<String, dynamic>> citas = await database.rawQuery(
          "SELECT * FROM Cita AS C INNER JOIN Recordatorio AS R ON C.id_cita = R.id_cita",
        );

        if(citas.length > 0) {
          for(int i = 0; i < citas.length; i++){
            recordsPageCards.add(Card(
              elevation: 3, // Elevación para dar profundidad al card
              margin: EdgeInsets.all(16), // Margen alrededor del card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    15), // Borde redondeado con radio de 15
              ),
              child: ListTile(
                leading: Icon(Icons.medical_services, size: 40),
                // Icono de medicina a la izquierda
                title: Text(
                  //citas[i]['motivo'].toString(),
                  'Cita Médica',
                  //Titulo
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hora: ' + citas[i]['fecha_hora']
                        .toString().split(" ")[1].split(".")[0]),
                    Text("Ubicacion: " +
                        citas[i]['ubicacion'].toString()),
                    //Dosis del medicamento
                  ],
                ),
                trailing: Text(
                  "Telefono: " +
                      citas[i]['telefono_medico'].toString(), //Fecha de inicio
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
            );
          }
        }

        print("citas: " + citas.length.toString());
        print("cards: " + homePageCards.length.toString());

        Navigator.pushAndRemoveUntil <dynamic>(
          context,
          MaterialPageRoute <dynamic>(
              builder: (BuildContext context) => const RecordsPage()
          ),
              (route) => false,
        );
      }
    }catch(exception){
      print(exception);
    }
  }
}

List<Widget> recordsPageCards = [];