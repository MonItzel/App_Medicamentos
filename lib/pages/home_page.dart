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
import 'package:permission_handler/permission_handler.dart';


String telCuidador = '';
String nomAdult = '';
String apellidos = '';
List<String> medicamentoInfoList = [];
List<String> citaInfoList = [];

int resMed = 0;
int resCita = 0;
bool CuidadorActivo = false; // Variable para rastrear el estado del cuidador
bool iconActivo = false;



class Resultado{
  String msgMed;
  String msgCita;
  int citayMed;
  Resultado(this.msgMed, this.msgCita, this.citayMed);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>with SingleTickerProviderStateMixin {

  final permissionSms = Permission.sms;

  int _currentIndex = 0;
  String formattedDate = '';
  bool _isLoading = true; // Añadido para controlar la carga de datos


  int resCreateNote = 0;

  //Mensajes animación
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,degTwoTranslationAnimation,degThreeTranslationAnimation;
  late Animation rotationAnimation;


  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }



  @override
  void initState()  {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2,end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.4,end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.75,end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0,end: 0.0).animate(CurvedAnimation(parent: animationController
        , curve: Curves.easeOut));
    super.initState();
    animationController.addListener((){
      setState(() {

      });
    });

    super.initState();

    ConsultUser(context).then((resultado) {
      // Actualizar la variable según el resultado de _ConsultUser
      setState(() {
        CuidadorActivo = resultado == 1;
      });
    });
    verificaMedyCita(context).then((result) {
        setState(() {
          iconActivo = result.citayMed == 1;
        });

    });
    _loadDate();
     CreateCards(context);
     _ConsultaMedicamentos(context);
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

  void smsPermissionStatus() async {
    // Request camera permission
    final status = await permissionSms.request();
    if (status.isGranted) { // Utiliza el valor almacenado en la variable 'status'
      _msgMedicamentAppointmentMsg(context);

      print('Opening SMS...');
    } else {
      // Permission denied
      print('SMS permission denied.');
    }
  }
  @override
  Widget build(BuildContext context) {
    //Al ingresar se crean las cartas.
    //CreateCards(context);
    double titleSpacing = resCreateNote == 1 ? 0.0 : 0.0;
    //double toolbarHeight = resCreateNote == 1 ? 140.0 : 80.0;
    Size size = MediaQuery.of(context).size;


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

          actions: CuidadorActivo
           ?<Widget>[
             /*IconButton(
                 onPressed: (){},
                 icon: Icon(Icons.call,
                   color: Colors.deepOrangeAccent,)
             )*/
             Padding(
               padding: const EdgeInsets.only(right: 25.0),
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
                     size: 32,

                   ),
                 ),
               ),
             )

           
          ]
          :null,

        ),
       /* floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: (iconActivo && CuidadorActivo) ? FloatingActionButton(
                backgroundColor: Color(0xFF0A3461),
                  onPressed: (){
                    _msgMedicamentAppointment(context) ;

                    },
                child: Icon(Icons.message),
              ) : null,
*/
        body: Stack(
          children: [
            Container(
              height: homePageCards.length * 170,
              child: new ListView(
                //Lista de cartas del día actual.
                children: homePageCards,
              )
            ),
            CuidadorActivo  && iconActivo ? Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: 30,
                      bottom: 30,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          IgnorePointer(
                            child: Container(
                              color: Colors.transparent,
                              height: 150.0,
                              width: 150.0,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(270),degOneTranslationAnimation.value * 100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                color: Color(0xFF2ACF49),
                                width: 55,
                                height: 55,
                                icon:Icon(
                                  Icons.message,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onClick: (){
                                  print('First Button');
                                  _msgMedicamentAppointmentWhats(context);
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(225),degTwoTranslationAnimation.value * 100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degTwoTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                color: Color(0xFF1483F5),
                                width: 55,
                                height: 55,
                                icon: Icon(
                                  Icons.sms,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onClick: (){
                                  smsPermissionStatus();
                                  print('Second button');
                                },
                              ),
                            ),
                          ),
                          /*
                          Transform.translate(
                            offset: Offset.fromDirection(getRadiansFromDegree(180),degThreeTranslationAnimation.value * 100),
                            child: Transform(
                              transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degThreeTranslationAnimation.value),
                              alignment: Alignment.center,
                              child: CircularButton(
                                color: Colors.orangeAccent,
                                width: 50,
                                height: 50,
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                onClick: (){
                                  print('Third Button');
                                },
                              ),
                            ),
                          ),*/
                          Transform(
                            //transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
                            transform: Matrix4.rotationZ(0),
                            alignment: Alignment.center,
                            child: CircularButton(
                              color: Color(0xFF0A3461),
                              width: 60,
                              height: 60,
                              icon: Icon(
                                Icons.messenger,
                                color: Colors.white,
                                size: 32,
                              ),
                              onClick: (){
                                if (animationController.isCompleted) {
                                  animationController.reverse();
                                } else {
                                  animationController.forward();
                                }
                              },
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ): Container(),
          ],
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
            IconData iconoCard = Icons.abc;
            if (horaDateTime.hour >= 6 && horaDateTime.hour < 12) {
              color = Color(0xFFDAEAF6);
              iconoCard = Icons.sunny;
            } else if (horaDateTime.hour >= 12 && horaDateTime.hour < 18) {
              color = Color(0xFFFCF4DD);
              iconoCard = Icons.wb_twilight_rounded;
            } else if (horaDateTime.hour < 6 || horaDateTime.hour >= 18) {
              color = Color(0xFFE8DFF5);
              iconoCard = Icons.mode_night_rounded;
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
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            iconoCard,
                            size: 30,
                          ),
                          Text(
                            horaFormateada,
                            style: AppStyles.dosisCard,
                          ),
                        ],
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

            Color color = Color(0xFFDDEDEA);
            IconData iconoCard = Icons.abc;
            if(horaDateTime.hour >= 6 && horaDateTime.hour < 12){
              iconoCard = Icons.sunny;
            }else if(horaDateTime.hour >= 12 && horaDateTime.hour <= 18){
              iconoCard = Icons.wb_twilight_rounded;
            }else if(horaDateTime.hour < 6 || horaDateTime.hour >= 18){
              iconoCard = Icons.mode_night_rounded;
            }
            homePageCards.add(Card(
              color: color,
              elevation: 3,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.medical_services, size: 44),
                  // Icono de medicina a la izquierda
                  title: const Text(
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
                        citas[i]['telefono_medico'].toString().split(
                            " ")[0], //Fecha de inicio
                        style: AppStyles.dosisCard,
                      ),
                      //Dosis del medicamento
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        iconoCard,
                        size: 30,
                      ),
                      Text(
                        citas[i]['fecha_hora'].toString().split(" ")[1].split(".")[0],
                        style: AppStyles.dosisCard,
                      ),
                    ],
                  ),
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
        return resCita;
      }else if(citaInfoList.length == 1){
        print('List citas tiene datos');
        resCita = 1;
        return resCita;
      }else{
        print('List citas mas de 1 cita');
        resCita = 2;
        return resCita;
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
  //int resMed =0;
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
            '\nMedicamento: \n${medicaments[i]['nombre'].toString()}\n'
                'Dosis: ${medicaments[i]['dosis'].toString()}\n'
                'Frecuencia: Cada ${medicaments[i]['frecuenciaToma'].toString()} horas\n'
                'Horario de toma:\n${horasFormateadas.join('\n')}'
        );


      }
    }
    if(medicamentoInfoList.isEmpty){
      print("List medicaments está vacia");
      resMed =0;
      return resMed;
    }
    else if(medicamentoInfoList.length == 1){
      print("List medicaments tiene un medicamento");
      resMed =1;
      return resMed;
    }else{
      print("List medicaments tiene mas de 1 medicamento");
      resMed =2;
      return resMed;
    }

  }catch(exception){
    print(exception);
    return 0;
  }
}




Future<void>_callCarer() async {
  //$telefono variable
  launchUrl(Uri.parse('tel: $telCuidador'));
}

/*
Future<void>_msgMedicamentAppointment(var context) async {
  //%20 es el espacio
  //Llamado a la función Parámetros a enviar
  // Llama a la función verificaMedyCita para obtener el resultado
  Resultado resultado = await verificaMedyCita(context);

  // Extrae los mensajes de medicamento y cita del resultado
  String mensajeMedicamento = resultado.msgMed;
  String mensajeCita = resultado.msgCita;
  //funcion
  print('nom_persona :' + nomAdult);
  print('apellidos :' + apellidos);

  print('tel cuidador ' + telCuidador);

  //print('msgmed: ' + medicamentoInfoList);
  //print('msgcita: ' + citaInfoList);

  String medicamentoInfo = medicamentoInfoList.join(', ');
  String citaInfo = citaInfoList.join(', ');

  print('medinfo' + medicamentoInfo);

  final uri = 'sms:$telCuidador?body=$nomAdult%20$apellidos%0A$mensajeMedicamento$medicamentoInfo%0A$mensajeCita%0A$citaInfo';
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
*/

Future<void>_msgMedicamentAppointmentMsg(var context) async {
  //%20 es el espacio
  //Llamado a la función Parámetros a enviar
  // Llama a la función verificaMedyCita para obtener el resultado
  Resultado resultado = await verificaMedyCita(context);

  // Extrae los mensajes de medicamento y cita del resultado
  String mensajeMedicamento = resultado.msgMed;
  String mensajeCita = resultado.msgCita;
  //funcion
  print('nom_persona :' + nomAdult);
  print('apellidos :' + apellidos);

  print('tel cuidador ' + telCuidador);

  //print('msgmed: ' + medicamentoInfoList);
  //print('msgcita: ' + citaInfoList);

  String medicamentoInfo = medicamentoInfoList.join(', ');
  String citaInfo = citaInfoList.join(', ');

  print('medinfo' + medicamentoInfo);

  final uri = 'sms:$telCuidador?body=$nomAdult%20$apellidos%0A$mensajeMedicamento$medicamentoInfo%0A$mensajeCita%0A$citaInfo';
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


Future<void>_msgMedicamentAppointmentWhats(var context) async {
  Resultado resultado = await verificaMedyCita(context);

  // Extrae los mensajes de medicamento y cita del resultado
  String mensajeMedicamento = resultado.msgMed;
  String mensajeCita = resultado.msgCita;

  String medicamentoInfo = medicamentoInfoList.join(', ');
  String citaInfo = citaInfoList.join(', ');

  // Reemplaza los espacios en blanco con %20 para el formato de URL
  //final mensajeUrl = Uri.encodeFull(mensaje);

  final uri = 'https://wa.me/$telCuidador/?text=$nomAdult%20$apellidos%0A$mensajeMedicamento$medicamentoInfo%0A$mensajeCita%0A$citaInfo';
  // final uri = 'https://wa.me/';

  print('Intentando abrir URL: $uri');

  if (await launchUrl(Uri.parse(uri))) {
    await launchUrl(Uri.parse(uri));
  }
  else{
    throw 'Could not launch $uri';
  }
}

Future<Resultado>verificaMedyCita(var context) async{
  if(resMed == 0 && resCita == 0 ){
    //print('No hay citas ni medicamentos');
    return Resultado('', '', 0);
  }
  else if(resMed == 1 && resCita == 0){
    //print('Tiene solo 1 medicamento');
    return Resultado('Tiene que tomar su medicamento', '', 1);
  }
  else if(resMed == 2 && resCita == 0){
    //print('Tiene más de 1 medicamento');
    return Resultado('Tiene que tomar sus medicamentos', '', 1);
  }
  else if(resMed == 2 && resCita == 1){
    //print('Tiene más de 1 medicamento');
    //print('Tiene  1 cita médica');
    return Resultado('Tiene que tomar sus medicamentos', 'Tiene una cita médica', 1);
  }
  else if(resMed == 0 && resCita == 1){
    //print('Tiene solo 1 cita médica');
    return Resultado('', 'Tiene una cita médica', 1);
  }
  else if(resMed == 0 && resCita == 2){
    //print('Tiene más de 1 cita médica');
    return Resultado('', 'Tiene las siguientes citas médicas', 1);
  }
  else if(resMed == 1 && resCita == 1){
    //print('Tiene más de 1 cita médica');
    return Resultado('Tiene que tomar su medicamento', 'Tiene una cita médica', 1);
  }
  else if(resMed == 1 && resCita == 2){
    //print('Tiene un medicamento y más de 1 cita médica');
    return Resultado('Tiene que tomar su medicamento', 'Tiene las siguientes citas médicas', 1);
  }
  throw Exception('Caso no manejado');

}

List<Widget> homePageCards = [];

class CircularButton extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final VoidCallback onClick;

  CircularButton({required this.color, required this.width, required this.height, required this.icon, required this.onClick});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color,shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: onClick),
    );
  }
}