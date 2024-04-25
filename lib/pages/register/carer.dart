import 'package:app_medicamentos/pages/register/ask_carer.dart';
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


class CarerPage extends StatefulWidget {
  const CarerPage({super.key, required this.user});

  //Objeto usado para almacenar los datos del usuario y registrarlo.
  final User user;

  @override
  State<StatefulWidget> createState() {
    return _CarerPage();
  }
}

class _CarerPage extends State <CarerPage> {

  var maskFormatter = MaskTextInputFormatter(mask: '### ### ####', filter: {"#": RegExp(r'[0-9]')});
  String buttonText = "Siguiente";
  @override
  Widget build(BuildContext context) {

    if(widget.user.id_usuario != null && nombreCuidadorController.text == '' && apellidoCuidadorController.text == '' && telefonoCuidadorController.text == ''){
      buttonText = 'Guardar';

      if(widget.user.cuidador_nombre.toString().split(',').length == 2){
        nombreCuidadorController.text = widget.user.cuidador_nombre.toString().split(',')[0];
        print('1 nombre' + nombreCuidadorController.text);
        apellidoCuidadorController.text = widget.user.cuidador_nombre.toString().split(',')[1];
      }else{
        if(widget.user.cuidador_nombre.toString()[0] == ','){
          apellidoCuidadorController.text = widget.user.cuidador_nombre.toString().split(',')[0];
          print('2 nombre' + nombreCuidadorController.text);
          nombreCuidadorController.text = '';
        }else{
          nombreCuidadorController.text = widget.user.cuidador_nombre.toString().split(',')[0].trim();
          apellidoCuidadorController.text = '';
        }
      }
      telefonoCuidadorController.text = widget.user.cuidador_telefono.toString();
    }

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
                nombreCuidadorController.text = '';
                apellidoCuidadorController.text = '';
                telefonoCuidadorController.text = '';

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
                      builder: (BuildContext context) => AskCarerPage(user: widget.user)
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
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nombre(s)',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: nombreCuidadorController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(

                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertoUpperCase(text, nombreCuidadorController, 0);
                        });
                      },
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Apellido(s)',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: apellidoCuidadorController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(

                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertoUpperCase(text, apellidoCuidadorController, 0);
                        });
                      },
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Número de telefono',
                    style: AppStyles.texto1,
                  ),
                ),
              ),

              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    decoration: AppStyles.contenedorTextForm,
                    child: TextFormField(
                      controller: telefonoCuidadorController,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatter],
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo,
                      style: AppStyles.texto1,
                    ),
                  ),
                ),
              ),



              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: () {
                        if(widget.user.id_usuario != null){
                          //Si el user ya tiene un id, actualiza la información del usuario
                          update(context);
                        }else{
                          //Al presionar el botón registra la usuario y va al HomePage.
                          register();
                          Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                                builder: (BuildContext context) => HomePage()
                            ),
                                (route) => false,
                          );
                        }
                      },
                      style: AppStyles.botonPrincipal,
                      child: Text(buttonText,
                        style: AppStyles.textoBoton
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
    cuidadorController.text = nombreCuidadorController.text + ' ' + apellidoCuidadorController.text;
    numCuidadorController.text = telefonoCuidadorController.text;
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    await database.transaction((txn) async {

      if(nombreCuidadorController.text != '' && apellidoCuidadorController.text != '')
        widget.user.cuidador_nombre = nombreCuidadorController.text + ", " + apellidoCuidadorController.text;
      else
        widget.user.cuidador_nombre = nombreCuidadorController.text + apellidoCuidadorController.text;
      widget.user.cuidador_telefono = telefonoCuidadorController.text.replaceAll(' ', '');

      var usuario = {
        'nombre': widget.user.nombre,
        'apellidoP': widget.user.apellidoP,
        'apellidoM': widget.user.apellidoM,
        'fechaNac': widget.user.fechaNac.toString(),
        'calle': widget.user.calle,
        'club': widget.user.club,
        'numero_exterior': widget.user.numExterior,
        'numero_interior': widget.user.numInterior,
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

    widget.user.cuidador_nombre = nombreCuidadorController.text + "," + apellidoCuidadorController.text;
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

    cuidadorController.text = widget.user.cuidador_nombre.toString().replaceAll(",", "");
    print('guarda ' + cuidadorController.text);
    numCuidadorController.text = widget.user.cuidador_telefono.toString();

    nombreCuidadorController.text = '';
    apellidoCuidadorController.text = '';
    telefonoCuidadorController.text = '';

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
