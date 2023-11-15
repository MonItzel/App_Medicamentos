import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _textMe();
                });
              },
              icon: Icon(
                Icons.message_rounded, color: Color(0xFFFCAC00), size: 50,),
            ),
            const SizedBox(height: 20,),

            IconButton(
              onPressed: () {
                setState(() {
                  _callMe();
                });
              },
              icon: Icon(Icons.call, color: Color(0xFF035600), size: 50,),
            ),
          ],
        ),
      ),
    );
  }

  _callMe() async {
    //$telefono variable
    launch('tel: 4448284676');
  }


  _textMe() async {
    //%20 es el espacio
    //Lamado a la    Parámetros a enviar
    //funcion
    const uri = 'sms:+4448284676?body=hello%20there';
    if (await canLaunch(uri)) {
      await launch(uri);
    }
    else {
      const uri = 'sms:0039-222-060-888?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

}
