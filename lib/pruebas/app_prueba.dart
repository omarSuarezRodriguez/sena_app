import 'package:flutter/material.dart';

import 'package:sena_app/pruebas/prueba_gridview_page.dart';
import 'package:sena_app/pruebas/wall_screen.dart';


class MyAppPrueba extends StatefulWidget {

  @override
  _MyAppPruebaState createState() => _MyAppPruebaState();
}

class _MyAppPruebaState extends State<MyAppPrueba> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: WallScreen(),

    );

  }
}