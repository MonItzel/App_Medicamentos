import 'package:app_medicamentos/models/user_model.dart';
import 'package:app_medicamentos/pages/register/ask_carer.dart';
import 'package:app_medicamentos/utils/flashMessage.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/address.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:app_medicamentos/constants.dart';
import '../profile/profile_page.dart';

class Pathologies extends StatefulWidget {
  const Pathologies({super.key, required User this.user, required List<String> this.pathologies});

  //Objeto usado para almacenar los datos del usuario y registrarlo.
  final User user;
  final List<String> pathologies;


  @override
  State<StatefulWidget> createState() {
    return _Pathologies();
  }
}

class _Pathologies extends State <Pathologies> {
  late bool _validateP = false;
  List<String> patologias = [];
  String buttonText = "Siguiente";
  List <String> pathDrop= [];
  List <String> others= [];
  List<List<String>>  allPath = [];



  @override
  void initState() {
    super.initState();
  }

  void eliminarElemento(String elemento) {
    setState(() {
      pathDrop.remove(elemento);
      others.remove(elemento);
      allPath.remove(elemento);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> allPath = [pathDrop, others];
    List<String> allPathList = allPath.expand((element) => element).toList();

    if(widget.pathologies.length > 0 && patologiasCards.isEmpty && otraspatController.text == ''){
      buttonText = 'Guardar';
      //otraspatController.text = widget.pathologies[widget.pathologies.length - 1];
    }

    List patologias = ['Diabetes Mellitus', 'Hipertensión arterial sistemática',
                       'Demencia o Alzheimer', 'Artritis', 'Osteoporosis',
                       'Cardiopatias', 'Parkinson', 'Depresión'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            'Registro',
            style: AppStyles.encabezado1
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
            onPressed: () {
              if(widget.pathologies.length > 0){
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => ProfilePage()
                  ),
                      (route) => false,
                );
              }else{
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  MaterialPageRoute <dynamic>(
                      builder: (BuildContext context) => Address(user: widget.user,)
                  ),
                      (route) => false,
                );
              }
            },
          ),
          actions: const [],
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
        ),
      ),

      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 150),
        child: Form(
          //key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
            //padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Seleccione en caso de tener alguno(s) de estos padecimientos',
                      textAlign: TextAlign.left,
                      style: AppStyles.texto1,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Column(
                  children: [
                    DropDownTextField.multiSelection(
                      submitButtonColor: AppStyles.primaryBlue,
                      submitButtonText: '                            Aceptar                         ',
                      submitButtonTextStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textStyle: AppStyles.texto1,
                      dropdownColor: Colors.white,
                      dropdownRadius: 12,
                      dropDownItemCount: 10, //La cantidad que te muestra al inicio, lo demás con el scroll
                      dropDownList: const [
                        DropDownValueModel(name: 'Artritis', value: "Artritis", /*toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values"*/),
                        DropDownValueModel(name: 'Artritis/Osteoartrosis', value: "Osteoartrosis"),
                        DropDownValueModel(name: 'Cardiopatías', value: "Cardiopatías"),
                        DropDownValueModel(name: 'Demencia o Alzheimer', value: "Demencia o Alzheimer"),
                        DropDownValueModel(name: 'Depresión', value: "Depresión"),
                        DropDownValueModel(name: 'Diabetes Mellitus', value: "Diabetes Mellitus"),
                        DropDownValueModel(name: 'Hipertensión arterial', value: "Hipertensión arterial", /* Muestra un dialog* toolTipMsg: "DropDownButton is a widget that we can use to select one unique value from a set of values"*/),
                        DropDownValueModel(name: 'Osteoporosis', value: "Osteoporosis"),
                        DropDownValueModel(name: 'Parkinson', value: "Parkinson"),
                      ],

                      onChanged: (val) {

                        setState(() {
                          //allPath.clear();
                          pathDrop.clear();
                          //others.clear();
                         allPath.clear();
                         //val= pathDrop;
                          for(int i=0; i<val.length; i++) {
                            print('ingreso a drop');
                            print(val[i].name);
                            pathDrop.add(val[i].name);
                           // allPath.add(pathDrop[i]);
                          }
                          print('despues del for');
                          allPath.add(pathDrop);
                          allPath.add(others);
                          print('allpath');
                          print(allPath);
                          savePathologies(val);
                        });

                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Padding(
                    padding:  EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Text(
                          'Padecimientos',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xFF002144), fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          width: 50, // El ancho del contenedor
                          height: 50, // La altura del contenedor
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Hace que el contenedor tenga forma de círculo
                            color: Color(0xFF0A3461), // Color de fondo con opacidad
                          ),
                          child: IconButton(
                            onPressed: (){
                              otraspatController.text = ""; // Esto borra el contenido del controlador

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Agregar padecimiento', style: TextStyle(fontSize: 23),),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Nombre de la patología     ',
                                          style: AppStyles.texto1,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 10,),
                                        Container(
                                          decoration: AppStyles.contenedorTextForm,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: TextFormField(
                                              controller: otraspatController,
                                              obscureText: false,
                                              textAlign: TextAlign.left,
                                              decoration: AppStyles.textFieldEstilo,
                                              style: AppStyles.texto1,

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF0A3461),
                                                minimumSize: Size(130, 45),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancelar'),
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFF0063C9),
                                                  minimumSize: Size(130, 45),
                                                ),
                                                onPressed: (){
                                                  if(otraspatController.text.isEmpty){
                                                    muestraSnackBar(context, 3);
                                                  }else{
                                                    setState(() {
                                                      print('allpath other');
                                                      print(allPath);

                                                    });
                                                    others.add(otraspatController.text);
                                                    allPath.add(others); // Agregar el contenido de `others` a `allPath`
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: Text('Agregar')
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.add, color: Colors.white, size: 30,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 230,
                  child: ListView.separated(
                    itemCount: allPathList.length,
                    separatorBuilder: (context, index) => Divider(), // Separador entre los elementos
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(
                          child: Icon(Icons.delete, color: Colors.white,),
                          color: Color(0xFFFF4337),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          print('indice: $index');

                          // Eliminar el elemento de todas las listas
                          setState(() {
                            String elementoEliminar = allPathList[index];
                            print(elementoEliminar);
                            allPathList.removeAt(index);

                            // Encuentra y elimina el mismo elemento de pathDrop y others
                            for (var lista in allPath) {
                              if (lista.contains(elementoEliminar)) {
                                lista.remove(elementoEliminar);
                              }
                            }
                          });


                        },
                        confirmDismiss: (direction) async{
                          bool result = false;
                          if (direction == DismissDirection.endToStart){
                           return await showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text('¿Esta seguro que desea eliminar este padecimiento?',),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF0A3461),
                                          minimumSize: Size(130, 45),
                                        ),
                                        onPressed: () {
                                          return Navigator.of(context).pop(false);
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      Spacer(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF0063C9),
                                            minimumSize: Size(130, 45),
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Aceptar')
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            );
                          });
                          }
                          return null;
                        },
                        key: ValueKey<String>(allPathList[index]),
                        child: ListTile(
                          title: Row(
                            children: [
                              //Icon(Icons.medical_information, color: Color(0xFF0A3461),),
                              //const SizedBox(width: 10,),
                              Text(allPathList[index], style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: () {
                        if(widget.pathologies.length > 0){
                          //Si el user ya tiene un id, actualiza la información del usuario
                          update(context);
                        }else{
                          print(otraspatController.text);
                          //Al presionar el botón registra las patologías seleccioandas.
                          register();
                          Navigator.pushAndRemoveUntil <dynamic>(
                            context,
                            MaterialPageRoute <dynamic>(
                                builder: (BuildContext context) => AskCarerPage(user: widget.user,)
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void>deletePath(String id)async{
    allPath.remove(id);
  }


  void savePathologies(dynamic val){
    var patologiasRaw = val;
    patologias.clear();

    List<String> patologias1 = patologiasRaw.toString().split('(');
    for(int i = 0; i < patologias1.length; i++){
      patologias.add(patologias1[i].split(', ')[0]);
    }
    patologias.removeAt(0);
    print(patologias);
    print(otraspatController.text);
  }

  //Crea las tablas en la base de datos y registra los padecimientos.
  void register() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    try {
      await database.transaction((txn) async {
        String sql =
            'CREATE TABLE IF NOT EXISTS Usuario (id_usuario INTEGER PRIMARY KEY, '
            'nombre TEXT, '
            'apellidoP TEXT,  '
            'apellidoM TEXT,  '
            'fechaNac REAL,  '
            'telefono TEXT, '
            'calle TEXT, '
            'club TEXT, '
            'numero_exterior TEXT, '
            'numero_interior TEXT, '
            'cuidador_activo INTEGER, '
            'cuidador_nombre TEXT, '
            'cuidador_telefono TEXT); ';
        txn.rawQuery(sql);

        sql =
        'CREATE TABLE IF NOT EXISTS Padecimiento (id_padecimiento INTEGER PRIMARY KEY, '
            'nombre_padecimiento TEXT); ';
        txn.rawQuery(sql);

        sql = 'CREATE TABLE IF NOT EXISTS Medicamento (id_medicamento INTEGER PRIMARY KEY, '
            'nombre TEXT, '
            'descripcion TEXT,  '
            'dosis TEXT,  '
            'inicioToma REAL,  '
            'finToma REAL,'
            'frecuenciaTipo TEXT,  '
            'frecuenciaToma INTEGER); ';
        txn.rawQuery(sql);

        sql = 'CREATE TABLE IF NOT EXISTS Cita (id_cita INTEGER PRIMARY KEY, '
            'nombre_medico TEXT, '
            'motivo TEXT,  '
            'especialidad_medico TEXT,  '
            'ubicacion TEXT,  '
            'telefono_medico TEXT,  '
            'fecha TEXT); ';
        txn.rawQuery(sql);

        sql = 'CREATE TABLE IF NOT EXISTS Recordatorio (id_recordatorio INTEGER PRIMARY KEY, '
            'tipo TEXT, '
            'id_medicamento INTEGER,  '
            'id_cita INTEGER, '
            'fecha_hora TEXT);  ';
        txn.rawQuery(sql);

        sql =
        'CREATE TABLE IF NOT EXISTS RecordatotioRegistro (id_registro INTEGER PRIMARY KEY, '
            'fecha TEXT); ';
        txn.rawQuery(sql);

        var map = txn.rawQuery('DELETE FROM Padecimiento');

        //Inserta los padecimientos de la lista y el padecimiento ingresado por el usuario.
        for (int i = 0; i < patologias.length; i++) {
          var padecimiento = {
            'nombre_padecimiento': patologias[i].toString(),
          };

          var id2 = txn.insert('Padecimiento', padecimiento);

          print(padecimiento["nombre_padecimiento"].toString() + " insertado.");
        }

        if(otraspatController.text != ''){
          List<String> otrasPatologias = otraspatController.text.split(', ');
          for(int i = 0; i < otrasPatologias.length; i++){
            var otroPadecimiento = {
              'nombre_padecimiento': otrasPatologias[i].trim(),
            };

            var id2 = txn.insert('Padecimiento', otroPadecimiento);
            print(otrasPatologias[i].trim() + " insertado.");
          }
        }
      });

      final List<Map<String, dynamic>> map2 = await database.rawQuery(
        'SELECT * FROM Padecimiento LIMIT 1',
      );
    }catch(exception) {
      print(exception);
    }


    //Registra la fecha actual como la primera vez que de generaron recordatorios.
    final List<Map<String, dynamic>> r = await database.rawQuery(
      "INSERT INTO RecordatotioRegistro (fecha) VALUES ('" + DateTime.now().toString().split(" ")[0] + "')",
    );
    print("INSERT INTO RecordatotioRegistro (fecha) VALUES ('" + DateTime.now().toString().split(" ")[0] + "')");
  }

  void update(BuildContext context) async{

    patologiasCards.clear();

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    await database.transaction((txn) async {
      var id1 = txn.rawQuery('DELETE FROM Padecimiento');
    });

    for (int i = 0; i < patologias.length; i++) {
      var padecimiento = {
        'nombre_padecimiento': patologias[i].toString(),
      };

      await database.transaction((txn) async {
        var id2 = txn.insert('Padecimiento', padecimiento);
      });

      print(padecimiento["nombre_padecimiento"].toString() + " insertado.");
    }

    if(otraspatController.text != ''){
      List<String> otrasPatologias = otraspatController.text.split(', ');
      for(int i = 0; i < otrasPatologias.length; i++){
        var otroPadecimiento = {
          'nombre_padecimiento': otrasPatologias[i].trim(),
        };

        await database.transaction((txn) async {
          var id2 = txn.insert('Padecimiento', otroPadecimiento);
        });
        print(otrasPatologias[i].trim() + " insertado.");
      }
    }

    Navigator.pushAndRemoveUntil <dynamic>(
      context,
      MaterialPageRoute <dynamic>(
          builder: (BuildContext context) => new ProfilePage()
      ),
          (route) => false,
    );
  }
}

final otraspatController = TextEditingController();

