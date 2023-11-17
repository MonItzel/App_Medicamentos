import 'package:app_medicamentos/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CarerPage extends StatefulWidget {
  const CarerPage({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() {
    return _CarerPage();
  }
}

class _CarerPage extends State <CarerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Registro de cuidador',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => StartPage()
                ),
                    (route) => false,
              );
            },
          ),
          actions: const [],
          backgroundColor: const Color(0xFFEDF2FA),
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: nombreCuidadorController,
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid
                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Nombre',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            controller: apellidoCuidadorController,
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid

                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Apellido',
            ),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            controller: telefonoCuidadorController,
            obscureText: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid

                  )
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Número de teléfono',
            ),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 193,
              height: 77,
              child: ElevatedButton(
                onPressed: () {
                  register();
                  Navigator.pushAndRemoveUntil <dynamic>(
                    context,
                    MaterialPageRoute <dynamic>(
                        builder: (BuildContext context) => HomePage()
                    ),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0063C9),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )
                ),
                child: Text("Siguiente",
                  style: TextStyle(
                      fontSize: 26
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    await database.transaction((txn) async {

      widget.user.cuidador_nombre = nombreCuidadorController.text + " " + apellidoCuidadorController.text;
      widget.user.cuidador_telefono = telefonoCuidadorController.text;

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
}

TextEditingController nombreCuidadorController = TextEditingController();
TextEditingController apellidoCuidadorController = TextEditingController();
TextEditingController telefonoCuidadorController = TextEditingController();
