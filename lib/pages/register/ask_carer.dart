import 'package:app_medicamentos/pages/register/carer.dart';
import 'package:app_medicamentos/pages/register/pathologies.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:app_medicamentos/constants.dart';

import '../profile/profile_page.dart';


class AskCarerPage extends StatefulWidget {
  const AskCarerPage({super.key, required this.user});

  //Objeto usado para almacenar los datos del usuario y registrarlo.
  final User user;

  @override
  State<StatefulWidget> createState() {
    return _AskCarerPage();
  }
}

class _AskCarerPage extends State <AskCarerPage> {

  var maskFormatter = MaskTextInputFormatter(mask: '### ### ####', filter: {"#": RegExp(r'[0-9]')});
  String buttonText = "Siguiente";
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
              widget.user.id_usuario != null ? 'Editar cuidador' : 'Registro del cuidador',
            style: AppStyles.encabezado1
          ),
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black
            ),
            onPressed: () {
              if(widget.user.id_usuario != null){
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => ProfilePage()
                  ),
                      (route) => false,
                );
              }
              else{
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => Pathologies(user: widget.user, pathologies: [],)
                  ),
                      (route) => false,
                );
              }
            },
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Si usted cuenta con una persona que esta a su cuidado y '
                        'desea agregar su contacto, seleccione Agregar',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    'El cuidador puede recibir los recordatorios de la toma de sus medicamentos'
                        'y sus citas medicas, tambien puede realizar llamadas de emergencia a este contacto',
                    style: AppStyles.texto3,
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil <dynamic>(
                          context,
                          MaterialPageRoute <dynamic>(
                              builder: (BuildContext context) => CarerPage(user: widget.user)
                          ),
                              (route) => false,
                        );
                      },
                      style: AppStyles.botonPrincipal,
                      child: const Text(
                        'Agregar cuidador',
                        style: AppStyles.textoBoton,
                      ),
                    ),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: (){
                        register();
                        Navigator.pushAndRemoveUntil <dynamic>(
                          context,
                          MaterialPageRoute <dynamic>(
                              builder: (BuildContext context) => HomePage()
                          ),
                              (route) => false,
                        );
                      },
                      style: AppStyles.botonSecundario,
                      child: Text(
                        'Continuar sin cuidador',
                        style: AppStyles.textoBoton,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  //Registra la inforamción del usuario y cuidador en la base de datos.
  void register() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    await database.transaction((txn) async {

      widget.user.cuidador_nombre = nombreCuidadorController.text + ", " + apellidoCuidadorController.text;
      widget.user.cuidador_telefono = telefonoCuidadorController.text.replaceAll(' ', '');

      var usuario = {
        'nombre': widget.user.nombre,
        'apellidoP': widget.user.apellidoP,
        'apellidoM': widget.user.apellidoM,
        'fechaNac': widget.user.fechaNac.toString(),
        'calle': widget.user.calle,
        'club': widget.user.club,
        'numero_exterior': widget.user.numExterior,
        'cuidador_activo': 0,
        'cuidador_nombre': widget.user.cuidador_nombre,
        'cuidador_telefono': widget.user.cuidador_telefono
      };

      var id1 = txn.insert('Usuario', usuario);

      print(widget.user.toMap().toString());
    });
  }

  void update(BuildContext context) async{
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    widget.user.cuidador_nombre = nombreCuidadorController.text + ", " + apellidoCuidadorController.text;
    widget.user.cuidador_telefono = telefonoCuidadorController.text.replaceAll(' ', '');

    int activeCarer = 0;
    if(widget.user.cuidador_telefono != '')
      activeCarer = 1;


    var usuario = {
      'id_usuario': widget.user.id_usuario,
      'cuidador_activo': activeCarer,
      'cuidador_nombre': widget.user.cuidador_nombre,
      'cuidador_telefono': widget.user.cuidador_telefono
    };

    await database.transaction((txn) async {
      var id1 = txn.update('Usuario', usuario);
    });

    cuidadorController.text = widget.user.cuidador_nombre.toString();
    numCuidadorController.text = widget.user.cuidador_telefono.toString();

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => ProfilePage()
      ),
          (route) => false,
    );
  }
}

TextEditingController nombreCuidadorController = TextEditingController();
TextEditingController apellidoCuidadorController = TextEditingController();
TextEditingController telefonoCuidadorController = TextEditingController();
