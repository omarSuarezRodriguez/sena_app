import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;


class AdministrarCategoriasPage extends StatelessWidget {
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
      title: Text('Administrar Categorías'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return ListView(
      children: <Widget>[

        // Item Lista de Categorías
        utils.itemListTile(context, 'Lista de Categorías', '/listacategoriaspage', FontAwesomeIcons.listUl, Colors.deepPurple[400]),

        Divider(),

        // Item Agregar Categoría
        utils.itemListTile(context, 'Agregar Categoría', '/agregarcategoriapage', FontAwesomeIcons.plusSquare, Color(0xff00E676)),

        Divider(),

        // Item Modificar Categoría
        utils.itemListTile(context, 'Modificar Categoría', '/modificarcategoriapage', FontAwesomeIcons.pencilAlt, Colors.indigoAccent),

        Divider(),

        // Item Eliminar Categoría
        utils.itemListTile(context, 'Eliminar Categoría', '/eliminarcategoriapage', FontAwesomeIcons.trashAlt, Colors.red),

        Divider(),

      ],
    );

  }


}