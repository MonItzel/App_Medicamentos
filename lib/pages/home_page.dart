import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/layout/bottom_navbar.dart';
import 'package:app_medicamentos/pages/calendar/calendar.dart';
import 'package:app_medicamentos/pages/records/records.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:page_transition/page_transition.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';

String telCuidador = '';
String nomAdult = '';
String apellidos = '';
List<String> medicamentoInfoList = [];
List<String> citaInfoList = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  String formattedDate = '';
  bool _isLoading = true; // Añadido para controlar la carga de datos
  bool tieneCuidadorActivo = false; // Variable para rastrear el estado del cuidador


  int resCreateNote = 0;
  @override
  void initState()  {
    super.initState();
    _loadDate();
     CreateCards(context);
     _ConsultaMedicamentos(context);
     ConsultUser(context).then((resultado) {
      // Actualizar la variable según el resultado de _ConsultUser
      setState(() {
        tieneCuidadorActivo = resultado == 1;
      });
    });

  }

  void _loadDate() async {
    await initializeDateFormatting('es', null);
    DateTime now = DateTime.now();
    setState(() {
      formattedDate = DateFormat.yMMMMd('es').format(now);
    });
    /*
    await Future.wait([
      CreateCards(context),
      ConsultaMedicamentos(context),
    ]);

    // Indicar que la carga ha terminado
    setState(() {
      _isLoading = false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    //Al ingresar se crean las cartas.
    //CreateCards(context);

    double titleSpacing = resCreateNote == 1 ? 0.0 : 0.0;
    //double toolbarHeight = resCreateNote == 1 ? 140.0 : 80.0;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppStyles.primaryBackground,
        appBar: AppBar(

  //        titleSpacing: 0.0,
//          toolbarHeight: 140.0,

          titleSpacing: titleSpacing,
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            children: [
              //if (resCreateNote == 1)
              //showTextEmergyCall(),
             /*Container(
                width: 100,
                height: 60,
                color: Colors.greenAccent,
                child: Text('Contacto de emergencia'),
              ),*/


              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 16, left: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.today, color: Colors.black, size: 42),
                        SizedBox(width: 16), // Espacio entre el icono y el texto
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hoy',
                              style: AppStyles.encabezado1,
                            ),
                            Text(
                              formattedDate,
                              style: AppStyles.encabezado2,
                            ),
                      ],
                    ),

                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),

          actions: tieneCuidadorActivo
           ?<Widget>[
             /*IconButton(
                 onPressed: (){},
                 icon: Icon(Icons.call,
                   color: Colors.deepOrangeAccent,)
             )*/
             Padding(
               padding: const EdgeInsets.only(right: 15.0),
               child: Container(
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Color(0xFF0A3461),
                 ),
                 child: IconButton(
                   onPressed: (){
                     _callCarer();
                   },
                   icon: Icon(
                     Icons.call,
                     color: Colors.white,

                   ),
                 ),
               ),
             )

           
          ]
          :null,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF0A3461),
            onPressed: (){
              //_callCarer();
              _msgMedicamentAppointment() ;

              },
          child: Icon(Icons.message),
        ),


        body: Container(
          height: homePageCards.length * 170,
          child: new ListView(
            //Lista de cartas del día actual.
            children: homePageCards,
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
                //Pagina actual, no necesita navegacion
              } else if (index == 1) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: CalendarPage(initialDate: DateTime.now(),),
                  ),
                  (route) => false,
                );
              } else if (index == 2) {
                //muestraButtonSheet();
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
      ),
    );
  }


  //Crea las cartas de los medicamentos y citas.
  Future<int> CreateCards(var context) async {
    try{
      if(homePageCards.isEmpty){
        Database database = await openDatabase(
            Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

        //Selecciona la información de los recordatorios de medicamentos del día actual.
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);
        print("SELECT * FROM Medicamento AS M INNER JOIN Recordatorio AS R ON M.id_medicamento = R.id_medicamento WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%'");

        final List<Map<String, dynamic>> medicamentos = await database.rawQuery(
          "SELECT * FROM Medicamento AS M INNER JOIN Recordatorio AS R ON M.id_medicamento = R.id_medicamento WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%' ORDER BY R.fecha_hora ASC",
          //'Delete FROM Medicamento; '
          //'Delete from Cita; '
          //'delete from Recordatorio;',
        );
        print("map: " + medicamentos.length.toString());
        print("cards: " + homePageCards.length.toString());

        //Crea las cartas para cada recordatorio de medicamento.
        if(medicamentos.length > 0) {
          for (int i = 0; i < medicamentos.length; i++) {
            String horaOriginal = medicamentos[i]['fecha_hora']
                .toString()
                .split(" ")[1].split(".")[0];
            // Analiza la hora original en un objeto DateTime
            DateTime horaDateTime = DateTime.parse("2022-01-01 $horaOriginal");
            // Formatea la hora en formato de 12 horas sin segundos
            String horaFormateada = DateFormat('hh:mm a').format(horaDateTime);
            Color color = Colors.white;
            if (horaDateTime.hour >= 6 && horaDateTime.hour < 12) {
              color = Colors.orange.shade50;
            } else if (horaDateTime.hour >= 12 && horaDateTime.hour < 18) {
              color = Colors.lightBlue.shade50;
            } else if (horaDateTime.hour < 6 || horaDateTime.hour >= 18) {
              color = Colors.indigo.shade50;
            }

            homePageCards.add(
              SizedBox(
                height: 120.0 + (medicamentos[i]['nombre']
                    .toString()
                    .length / 15 + 1) * 20,
                child: Card(
                  elevation: 3,
                  color: color,
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.medication_liquid, size: 44),
                      //Nombre del medicamento
                      title: Text(
                        medicamentos[i]['nombre'].toString(),
                        style: AppStyles.tituloCard,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicamentos[i]['dosis'].toString(),
                            style: AppStyles.dosisCard,
                          ),
                          Text(
                            'Cada ' +
                                medicamentos[i]['frecuenciaToma'].toString() +
                                ' ' + medicamentos[i]['frecuenciaTipo']
                                .toString() + 's',
                            style: AppStyles.dosisCard,
                          ),
                        ],
                      ),
                      trailing: Text(
                        horaFormateada,
                        style: AppStyles.dosisCard,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
        print( "SELECT * FROM Cita WHERE fecha LIKE '" + date.toString().split(" ")[0] + "%' ORDER BY fecha ASC");
        //Selecciona la información de los recordatorios de citas del día actual.
        final List<Map<String, dynamic>> citas = await database.rawQuery(
          "SELECT * FROM Cita AS C INNER JOIN Recordatorio AS R ON C.id_cita = R.id_cita WHERE R.fecha_hora LIKE '" + date.toString().split(" ")[0] + "%' ORDER BY R.fecha_hora ASC",
        );
        print("map: " + citas.length.toString());
        print("cards: " + homePageCards.length.toString());

        citaInfoList.clear();
        //Crea las cartas para cada recordatorio de cita.
        if(citas.length > 0) {
          for (int i = 0; i < citas.length; i++) {
            String horaOriginal = citas[i]['fecha'].toString().split(" ")[1].split(".")[0];
            // Analiza la hora original en un objeto DateTime
            DateTime horaDateTime = DateTime.parse("2022-01-01 $horaOriginal");

            // Formatea la hora en formato de 12 horas sin segundos
            String horaFormateada = DateFormat('hh:mm a').format(horaDateTime);

            citaInfoList.add(
                'Hora: ${horaFormateada}\n'
                    'Ubicacion: ${citas[i]['ubicacion'].toString()} \n'
                    'Teléfono : ${citas[i]['telefono_medico'].toString().split(" ")[0]}\n'
            );

            Color color = Colors.white;
            if(horaDateTime.hour >= 6 && horaDateTime.hour < 12){
              color = Colors.orange.shade50;
            }else if(horaDateTime.hour >= 12 && horaDateTime.hour <= 18){
              color = Colors.lightBlue.shade50;
            }else if(horaDateTime.hour < 6 || horaDateTime.hour >= 18){
              color = Colors.indigo.shade50;
            }
            homePageCards.add(Card(
              color: color,
              elevation: 3,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.medical_services, size: 40),
                // Icono de medicina a la izquierda
                title: const Text(
                  //citas[i]['motivo'].toString(),
                  'Cita Médica',
                  //Titulo
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hora: ' + citas[i]['fecha_hora'].toString().split(" ")[1].split(".")[0]),
                    Text("Ubicacion: " +
                        citas[i]['ubicacion'].toString()),
                    //Dosis del medicamento
                  ],
                ),
                trailing: Text(
                  "Telefono: " +
                      citas[i]['telefono_medico'].toString().split(
                          " ")[0], //Fecha de inicio
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
            );
          }
        }

        if(homePageCards.length != medicamentos.length + citas.length){
          homePageCards = [];
        }

        //Si se generaron cartas vuelve a generar la pantalla.
        if(medicamentos.length > 0 || citas.length > 0)
          Navigator.pushAndRemoveUntil <dynamic>(
            context,
            MaterialPageRoute <dynamic>(
                builder: (BuildContext context) => const HomePage()
            ),
                (route) => false,
          );
      }
      if(citaInfoList.isEmpty){
        print('List citas está vacia');
        return 1;
      }else{
        print('List citas tiene datos');
        return 0;
      }

    }catch(exception){
      print(exception);
      return 0;
    }
  }
}


Future<int>ConsultUser(var context) async {
  try {
    Database database = await openDatabase(
        Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> result = await database.query(
      'Usuario',
      columns: ['*'],
      where: 'cuidador_telefono IS NOT NULL AND TRIM(cuidador_telefono) != ?',
      whereArgs: [''],
    );

    // Imprimir los resultados de la consulta
    print('Resultados de la consulta: $result');

    // Verificar si la lista de resultados no está vacía
    if (result.isNotEmpty) {
      print('Tiene cuidador activo');
      telCuidador = result[0]['cuidador_telefono'].toString();
      nomAdult = result[0]['nombre'].toString();
      String apellidoP = result[0]['apellidoP'].toString();
      String apellidoM = result[0]['apellidoM'].toString();
      apellidos = '$apellidoP ${apellidoM.isNotEmpty ? apellidoM : ''}';
      print('variable tel_cuidador');
      print(telCuidador);
      print('nombre Adult' + nomAdult);

      return 1;
    } else {
      print('No tiene cuidador activo');
      return 0;
    }
  } catch (e) {
    print('Error al verificar cuidador activo: $e');
    return 0;
  }
}



Future<int>_ConsultaMedicamentos(var context) async{
  medicamentoInfoList.clear();
  try{
    Database database = await openDatabase(
        Path.join(await getDatabasesPath(), 'medicamentos.db'), version: 1);
    final List<Map<String, dynamic>> medicaments = await database.rawQuery(
      "SELECT DISTINCT M.nombre, M.dosis, M.inicioToma, M.frecuenciaToma, M.frecuenciaTipo " +
          "FROM Medicamento AS M " +
          "INNER JOIN Recordatorio AS R ON M.id_medicamento = R.id_medicamento " +
          "WHERE R.fecha_hora LIKE '%" + date.toString().split(" ")[0] + "%' " +
          "ORDER BY R.fecha_hora ASC",
    );
    //  medicamentoInfoList.clear();

    print("map 2: " + medicaments.length.toString());
    print("medicamento consulta: " + medicaments.toString());
    if(medicaments.length > 0){
      for(int i = 0; i < medicaments.length; i++){
        print("medicamento consultas: " + medicaments[i].toString());

        String hOrigin = medicaments[i]['inicioToma'].toString().split(" ")[1].split(".")[0];
        DateTime horaDateTime2 = DateTime.parse("2022-01-01 $hOrigin");
        // Formatea la hora en formato de 12 horas sin segundos
        String horaFormateada2 = DateFormat('hh:mm a').format(horaDateTime2);

        int frecuenciaToma = medicaments[i]['frecuenciaToma'];
        int minutosTotales = horaDateTime2.hour * 60 + horaDateTime2.minute;

        List<String> horasFormateadas = [];

        for (int minutos = minutosTotales; minutos < 24 * 60; minutos += frecuenciaToma * 60) {
          int horas = minutos ~/ 60;
          int minutosRestantes = minutos % 60;

          String horaFormateada = DateFormat('hh:mm a').format(DateTime(2022, 1, 1, horas, minutosRestantes));

          //print("Hora Formateada: $horaFormateada");
          horasFormateadas.add(horaFormateada);
        }

        //medicamentoInfoList.clear();
        medicamentoInfoList.add(
            'Medicamento: \n${medicaments[i]['nombre'].toString()}\n'
                'Dosis: ${medicaments[i]['dosis'].toString()}\n'
                'Frecuencia: Cada ${medicaments[i]['frecuenciaToma'].toString()} horas\n'
                'Horario de toma:\n${horasFormateadas.join('\n')}'
        );


      }
    }
    if(medicamentoInfoList.isEmpty){
      print("List medicaments está vacia");
      return 0;
    }
    else{
      print("List medicaments tiene datos");
      return 1;
    }

  }catch(exception){
    print(exception);
    return 0;
  }
}




_callCarer() async {
  //$telefono variable
  launchUrl(Uri.parse('tel: $telCuidador'));
}

_msgMedicamentAppointment() async {
  //%20 es el espacio
  //Llamado a la función Parámetros a enviar
  //funcion
  print('nom_persona :' + nomAdult);
  print('apellidos :' + apellidos);

  print('tel cuidador ' + telCuidador);

  //print('msgmed: ' + medicamentoInfoList);
  //print('msgcita: ' + citaInfoList);
  final uri = 'sms:$telCuidador?body=$nomAdult%20$apellidos%0ATiene%20que%20tomar%20sus%20medicamentos%0A$medicamentoInfoList%0ATiene%20una%20cita%20médica%0A$citaInfoList';
  //const uri = 'sms:+4448284676?body=Yessica%20Téllez%20Martínez%0ATiene%20una%20cita%20médica%0AFecha:%0AHora:%0ANombre%20del%20doctor:%0ANúmero%20del%20cuidador%0ALugar:';

  //final mensaje = '$nomAdult $apellidos\nTiene que tomar sus medicamentos\n$medicamentoInfoList\nTiene una cita médica\n$citaInfoList';

  // Reemplaza los espacios en blanco con %20 para el formato de URL
  //final mensajeUrl = Uri.encodeFull(mensaje);

 //final uri = 'https://wa.me/$tel_cuidador/?text=estoesunaprueba';
 // final uri = 'https://wa.me/';

  print('Intentando abrir URL: $uri');

  if (await canLaunchUrl(Uri.parse(uri))) {
    await launchUrl(Uri.parse(uri));
  }
 /* else if(await canLaunchUrl(Uri.parse(uri2))){
    await launchUrl(Uri.parse(uri2));
  }*/
  else{
    throw 'Could not launch $uri';
  }
}

List<Widget> homePageCards = [];
