import 'package:flutter/material.dart';


class PantallaCompletaProductoPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    String imagenUrl = ModalRoute.of(context).settings.arguments;

    return Scaffold(

      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: imagenUrl,
            child: FadeInImage(
                image: NetworkImage(imagenUrl),
                placeholder: AssetImage('assets/images/loading.jpg'),
                // height: _screenSize.height * 0.27,
                // height: _screenSize.height * 0.26, // Visualizar en emulador
                // width: double.infinity,
                // fit: BoxFit.cover,
                fit: BoxFit.contain,
            ),
          ),
        ),

        onTap: () => Navigator.pop(context),

      ),

    );

  }
}