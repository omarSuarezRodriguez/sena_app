import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;


class AdministrarProductosPage extends StatelessWidget {
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
      title: Text('Administrar Productos'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return ListView(
      children: <Widget>[

        // Item Lista de Productos
        utils.itemListTile(context, 'Lista de Productos', '/listaproductospage', FontAwesomeIcons.listUl, Colors.deepPurple[400]),

        Divider(),

        // Item Agregar Producto
        utils.itemListTile(context, 'Agregar Producto', '/agregarproductopage', FontAwesomeIcons.plusSquare, Color(0xff00E676)),

        Divider(),

        // Item Modificar Producto
        utils.itemListTile(context, 'Modificar Producto', '/listamodificarproductopage', FontAwesomeIcons.pencilAlt, Colors.indigoAccent),

        Divider(),

        // Item Eliminar Producto
        utils.itemListTile(context, 'Eliminar Producto', '/eliminarproductopage', FontAwesomeIcons.trashAlt, Colors.red),

        Divider(),

        
      ],
    );

  }
















}