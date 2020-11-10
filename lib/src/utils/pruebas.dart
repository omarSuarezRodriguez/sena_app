// Page sólo para hacer pruebas

import 'package:flutter/material.dart';


class PruebaPage extends StatefulWidget {
  @override
  _PruebaPageState createState() => _PruebaPageState();
}

class _PruebaPageState extends State<PruebaPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => print('Hola'),
      ),
    );
  }
}
