import 'package:app_medicamentos/pages/records/records.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:app_medicamentos/pages/medicaments_register/medicaments_register_date.dart';
import 'package:app_medicamentos/models/medicament_model.dart';
import 'package:app_medicamentos/utils/convert_Uppercase.dart';
import 'package:app_medicamentos/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

enum Frequency { horas, dias, semanas, meses  }

class MedicamentNameRegister extends StatefulWidget {
  MedicamentNameRegister({super.key, required this.initMedicament});
  final Medicament initMedicament;

  @override
  State<StatefulWidget> createState() {
    return _MedicamentNameRegister();
  }
}

class _MedicamentNameRegister extends State <MedicamentNameRegister> {

  //Objeto usado para pasar la información del medicamento de esta pantalla a la suiguiente.
  Medicament medicament = Medicament();
  final  freqHour = TextEditingController();
  final  freqDay = TextEditingController();
  final  freqWeek = TextEditingController();
  final  freqMonth = TextEditingController();

  final FocusNode focusNodeHour = FocusNode();
  final FocusNode focusNodeDay = FocusNode();
  final FocusNode focusNodeWeek = FocusNode();
  final FocusNode focusNodeMonth = FocusNode();

  Frequency? _frequency;

  bool isContainerVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNodeHour.addListener(() {
      if (focusNodeHour.hasFocus) {
        _clearOtherTextFields(Frequency.horas);
        setState(() {
          _frequency = Frequency.horas;
        });
      }
    });

    focusNodeDay.addListener(() {
      if (focusNodeDay.hasFocus) {
        _clearOtherTextFields(Frequency.dias);
        setState(() {
          _frequency = Frequency.dias;
        });
      }
    });

    focusNodeWeek.addListener(() {
      if (focusNodeWeek.hasFocus) {
        _clearOtherTextFields(Frequency.semanas);
        setState(() {
          _frequency = Frequency.semanas;
        });
      }
    });

    focusNodeMonth.addListener(() {
      if (focusNodeMonth.hasFocus) {
        _clearOtherTextFields(Frequency.meses);
        setState(() {
          _frequency = Frequency.meses;
        });
      }
    });
  }

  void _clearOtherTextFields(Frequency selectedFrequency) {
    if (selectedFrequency != Frequency.horas) freqHour.clear();
    if (selectedFrequency != Frequency.dias) freqDay.clear();
    if (selectedFrequency != Frequency.semanas) freqWeek.clear();
    if (selectedFrequency != Frequency.meses) freqMonth.clear();
  }

  @override
  void dispose() {
    freqHour.dispose();
    freqDay.dispose();
    freqWeek.dispose();
    freqMonth.dispose();

    focusNodeHour.dispose();
    focusNodeDay.dispose();
    focusNodeWeek.dispose();
    focusNodeMonth.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(currentMedicament.id_medicamento != null)
      medicament = currentMedicament;
    else
      medicament = widget.initMedicament;

    if(nombreController.text == "" && dosisController.text == ""){
      nombreController.text = medicament.nombre != null? medicament.nombre.toString() : "";
      dosisController.text = medicament.dosis != null? medicament.dosis.toString() : "";
      switch(medicament.frecuenciaTipo){
        case "Hora":
          freqHour.text = medicament.frecuenciaToma.toString();
          _frequency = Frequency.horas;
        case "Dia":
          freqDay.text = medicament.frecuenciaToma.toString();
          _frequency = Frequency.dias;
        case "Semana":
          freqWeek.text = medicament.frecuenciaToma.toString();
          _frequency = Frequency.semanas;
         case "Mes":
           freqMonth.text = medicament.frecuenciaToma.toString();
           _frequency = Frequency.meses;
      }
    }
    currentMedicament = Medicament();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppStyles.primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            medicament.id_medicamento != null ? 'Editar medicamento' : 'Agregar medicamento',
            style: AppStyles.encabezado1,
          ),

          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black
            ),
            onPressed: () {
              if(medicament.id_medicamento != null){
                update = false;
                currentMedicament = Medicament();
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    child: const RecordsPage(),
                  ),
                      (route) => false,
                );
              }
              else{
                Navigator.pushAndRemoveUntil <dynamic>(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    child: const HomePage(),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nombre del medicamento',
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
                      controller: nombreController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(

                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertFirstWordUpperCase(text, nombreController);
                        });
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Dosis',
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
                      controller: dosisController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: AppStyles.textFieldEstilo.copyWith(

                      ),
                      style: AppStyles.texto1,
                      onChanged: (text) {
                        setState(() {
                          convertFirstWordUpperCase(text, dosisController);
                        });
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Frecuencia',
                    style: AppStyles.texto1,
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 1.0),
                padding: EdgeInsets.all(10.0),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),

                child: Column(
                  children: <Widget>[
                    RadioListTile<Frequency>(
                      activeColor: Color(0xFF0D1C52),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.end, // Alinea los elementos a la parte inferior
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: freqHour,
                              focusNode: focusNodeHour,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF0D1C52)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              'Horas',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      value: Frequency.horas,
                      groupValue: _frequency,
                      onChanged: (Frequency? value) {
                        setState(() {
                          _frequency = value;
                          FocusScope.of(context).requestFocus(focusNodeHour);
                        });
                      },
                    ),
                    RadioListTile<Frequency>(
                      activeColor: Color(0xFF0D1C52),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.end, // Alinea los elementos a la parte inferior
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: freqDay,
                              focusNode: focusNodeDay,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF0D1C52)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              'Días',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      value: Frequency.dias,
                      groupValue: _frequency,
                      onChanged: (Frequency? value) {
                        setState(() {
                          _frequency = value;
                          FocusScope.of(context).requestFocus(focusNodeDay);
                        });
                      },
                    ),
                    RadioListTile<Frequency>(
                      activeColor: const Color(0xFF0D1C52),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.end, // Alinea los elementos a la parte inferior
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: freqWeek,
                              focusNode: focusNodeWeek,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF0D1C52)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Semanas',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      value: Frequency.semanas,
                      groupValue: _frequency,
                      onChanged: (Frequency? value) {
                        setState(() {
                          _frequency = value;
                          FocusScope.of(context).requestFocus(focusNodeWeek);
                        });
                      },
                    ),
                    RadioListTile<Frequency>(
                      activeColor: Color(0xFF0D1C52),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.end, // Alinea los elementos a la parte inferior
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: freqMonth,
                              focusNode: focusNodeMonth,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF0D1C52)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Meses',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      value: Frequency.meses,
                      groupValue: _frequency,
                      onChanged: (Frequency? value) {
                        setState(() {
                          _frequency = value;
                          FocusScope.of(context).requestFocus(focusNodeMonth);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Container(
                    width: double.infinity,
                    height: AppStyles.altoBoton,
                    child: ElevatedButton(
                      onPressed: () {
                        //Al presionar el botón se llena el objeto y se pasa a la siguiente pantalla.
                        SetMedicamento();
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: MedicamentDateRegister(medicament: medicament,),
                          ),
                              (route) => false,
                        );
                      },
                      style: AppStyles.botonPrincipal,
                      child: const Text("Siguiente",
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

  //Almacena los dato ingresados en esta pantalla.
  void SetMedicamento(){
    medicament.nombre = nombreController.text;
    medicament.dosis = dosisController.text;

    switch(_frequency){
      case Frequency.horas:
        medicament.frecuenciaTipo = "Hora";
        medicament.frecuenciaToma = int.parse(freqHour.text);
      case Frequency.dias:
        medicament.frecuenciaTipo = "Dia";
        medicament.frecuenciaToma = int.parse(freqDay.text);
      case Frequency.semanas:
        medicament.frecuenciaTipo = "Semana";
        medicament.frecuenciaToma = int.parse(freqWeek.text);
      case Frequency.meses:
        medicament.frecuenciaTipo = "Mes";
        medicament.frecuenciaToma = int.parse(freqMonth.text);
      case null:
    }
  }
  TextEditingController nombreController = TextEditingController();
  TextEditingController dosisController = TextEditingController();
}