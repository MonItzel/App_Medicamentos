import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/profile/profile_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditProfile();
  }
}

class _EditProfile extends State <EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEDF2FA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          // Título de la AppBar
          title: Text(
            'Perfil',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          // Botón de retroceso que lleva de vuelta a la página de perfil
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF09184D)),
            onPressed: () {
              Navigator.pushAndRemoveUntil <dynamic>(
                context,
                MaterialPageRoute <dynamic>(
                    builder: (BuildContext context) => ProfilePage()
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

      // Cuerpo de la página
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Campo de texto para el nombre
          TextFormField(
            controller: nombreUController,
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
              hintText: 'Nombre(s)',
            ),
          ),
          SizedBox(height: 20.0,),

          // Campo de texto para los apellidos
          TextFormField(
            controller: apellidoUController,
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
              hintText: 'Apellidos',
            ),
          ),
          SizedBox(height: 20.0,),

          // Campo de texto para el teléfono
          TextFormField(
            controller: telefonoUController,
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
              hintText: 'Teléfono',
            ),
          ),
          SizedBox(height: 20.0,),

          // Botón de actualización del perfil
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Container(
              width: 193,
              height: 77,
              child: ElevatedButton(
                onPressed: () {
                  // Al presionar el botón actualizará el usuario y regresará a la página de inicio
                  UpdateProfile();
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
          )
        ],
      ),
    );
  }

  // Llena un objeto usuario y actualiza el único registro en la base de datos
  void UpdateProfile() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    // Al haber un solo usuario, basta con actualizar todos los registros con la información nueva
    await database.transaction((txn) async {
      var usuario = {
        'cuidador_nombre': nombreUController.text + " " + apellidoUController.text,
        'cuidador_telefono': telefonoUController.text
      };

      var id1 = txn.update('Usuario', usuario);

      print("Usuario actualizado: " + usuario.toString());
    });

    // Vacía los textos de la pantalla del perfil para refrescar la información que se muestra
    nombreController.text = "";
    apellidoPController.text = "";
    apellidoMController.text = "";
    fechaNacController.text = "";
    calleController.text = "";
    coloniaController.text = "";
    numExteriorController.text = "";
    cuidadorController.text = "";
  }

  // Controladores para manejar la entrada de texto en los campos del formulario
  TextEditingController nombreUController = TextEditingController();
  TextEditingController apellidoUController = TextEditingController();
  TextEditingController telefonoUController = TextEditingController();
}
