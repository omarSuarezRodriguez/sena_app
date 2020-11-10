import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;


class AdministrarClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: _appBarWidget(),

      body: _bodyWidget(context),


    );
  }


  // _appBar Widget
  Widget _appBarWidget() {

    return AppBar(
      //Con esta configuración podemos implementar boton para atras en AppBar
      automaticallyImplyLeading: true,
      backgroundColor: Color(0xffff3a5a),
      title: Text('Administrar Clientes'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return ListView(

      children: <Widget>[

        // Item Lista de Clientes
        utils.itemListTile(context, 'Lista de Clientes', '/listaclientespage', FontAwesomeIcons.listUl, Colors.deepPurple[400]),

        Divider(),

        // Item Agregar Cliente
        utils.itemListTile(context, 'Agregar Cliente', '/agregarclientepage', FontAwesomeIcons.plusSquare, Color(0xff00E676)),

        Divider(),

        // Item Modificar Cliente
        utils.itemListTile(context, 'Modificar Cliente', '/modificarclientepage', FontAwesomeIcons.pencilAlt, Colors.indigoAccent),

        Divider(),

        // Item Eliminar Cliente
        utils.itemListTile(context, 'Eliminar Cliente', '/eliminarclientepage', FontAwesomeIcons.trashAlt, Colors.red),

        Divider(),


      ],

    );

  }




}