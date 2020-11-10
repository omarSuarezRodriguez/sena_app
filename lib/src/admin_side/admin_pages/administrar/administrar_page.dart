import 'package:flutter/material.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;

// ==================================
// ==================================
// =========== Administrar ==========

class AdministrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _bodyWidget(context),
      
    );
  }


  // _bodyWidget
  Widget _bodyWidget(BuildContext context) {

    return ListView(
      children: <Widget>[

        // Item Productos
        utils.itemListTile(context, 'Productos', '/administrarproductospage', Icons.local_offer, Color(0xffff3a5a)),

        Divider(),

        // Item Categorías
        utils.itemListTile(context, 'Categorías', '/administrarcategoriaspage', Icons.dashboard, Colors.teal),

        Divider(),

        // Item Clientes
        utils.itemListTile(context, 'Clientes', '/administrarclientespage', Icons.face, Colors.indigoAccent),

        Divider(),

        // Item Cerrar sesión
        ListTile(
          leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
          title: Text("Cerrar Sesión"),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Cerrar Sesión'),
                    content: Text('¿Desea cerrar sesión?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Si'),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (_) => false);
                        },
                      ),
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        Divider(),

      ],
    );
  
  }


  



}

// ==================================
// ==================================