import 'package:app_medicamentos/splash_screen.dart';
import 'package:app_medicamentos/utils/forwarder.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:app_medicamentos/provider/patprovider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants.dart';

void main() {
  //runApp(const MyApp());
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //select(context);
    final baseColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    // Copia el ColorScheme y ajusta el color primario.
    final customColorScheme = baseColorScheme.copyWith(
      primary: Colors.blue, // Ajusta el color primario al azul exacto
      tertiaryContainer: Color(0xFFA7CFFC),

    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: customColorScheme,

          primaryColor: Colors.blue,
        //useMaterial3: true
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,  // Añadido para soportar Cupertino widgets
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      //ignore: always_specify_types
      supportedLocales: const [
        Locale('es'),
        // ... other locales the app supports
      ],
      locale: const Locale('es'),
      //Forwarder es la funcion para verificar si existe algun usuario registrado en la app
      //Si el usuario se ha registrado entre al HomePage, sino se muestra el formulario de registro
      //home: Forwarder(),
      home: SplashScreenP(),

    );
  }


  Future<void> select(var context) async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'medicamentos.db'), version: 1);

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    if(map1.length > 0) {
      print(map1[0]['nombre'].toString());

      Navigator.pushAndRemoveUntil <dynamic>(
        context,
        MaterialPageRoute <dynamic>(
            builder: (BuildContext context) => const HomePage()
        ),
            (route) => false,
      );
    }else{
      Navigator.pushAndRemoveUntil <dynamic>(
        context,
        MaterialPageRoute <dynamic>(
            builder: (BuildContext context) => const StartPage()
        ),
            (route) => false,
      );
    }
  }
}


