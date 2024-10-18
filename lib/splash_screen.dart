import 'package:app_medicamentos/utils/forwarder.dart';
import 'package:flutter/material.dart';

class SplashScreenP extends StatefulWidget {
  const SplashScreenP({super.key});

  @override
  State<SplashScreenP> createState() => _SplashScreenPState();
}

class _SplashScreenPState extends State<SplashScreenP> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navegar a la siguiente pantalla después de 3 segundos
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Forwarder()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtén el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.3, // 20% del ancho de la pantalla
              height: screenHeight * 0.1, // 10% del alto de la pantalla
              child: Image.asset('assets/images/logo_apesaam.png'),
            ), // Asegúrate de que la imagen está en la ruta correcta
            const SizedBox(height: 20,),

            AnimatedOpacity(
              opacity: _animation.value,
              duration: const Duration(seconds: 2),
              child: Container(
                width: screenWidth * 0.85, // 80% del ancho de la pantalla
                height: screenHeight * 0.12, // 10% del alto de la pantalla
                child: Image.asset('assets/images/app_name11.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
