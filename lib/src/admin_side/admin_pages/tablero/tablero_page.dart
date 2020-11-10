import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class TableroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: _bodyWidget(context),

    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return Column(

      children: <Widget>[

        Expanded(

          child: GridView(

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

            children: <Widget>[

              // Recuadro de Productos
              _crearRecuadroDeTablero(context, 'Productos', 'productos', '/listaproductospage', Icons.local_offer, Colors.red),

              // Recuadro de Categorias
              _crearRecuadroDeTablero(context, 'Categorías', 'categorias', '/listacategoriaspage', Icons.dashboard, Colors.teal),

              // Recuadro Clientes
              _crearRecuadroDeTablero(context, 'Clientes', 'clientes', '/listaclientespage', Icons.face, Colors.indigoAccent),

            ],

          ),

        ),

      ],



    );

  }


  // _crearRecuadroDeTablero
  // Sirve para crear cada recuadro que se muestra en el tablero
  Widget _crearRecuadroDeTablero(BuildContext context, String titulo, String collectionName,
    String pageRoute, IconData icono, Color color) {


    // Obtenemos los documentos o snapshots de la collection
    getDocuments() {
      return Firestore.instance
        .collection(collectionName)
        .snapshots();
    }


    // Obtenemos el Nro de documentos en un Text
    textoConNumeroDeDocumentos(BuildContext context) {

      return StreamBuilder<QuerySnapshot>(
        stream: getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          if (snapshot.hasData) {
            print("Nro Documentos: ${snapshot.data.documents.length}");
            return Text(
              "${snapshot.data.documents.length}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xffff3a5a), fontSize: 55.0),
            );
          }
          return CircularProgressIndicator();
        },
      );  

    }


    // Devolvemos la card con la info
    return Padding(
      padding: const EdgeInsets.all(9.0),

      child: Card(
        elevation: 2.5,

        child: InkWell(
          // Al clickear la card
          onTap: () => Navigator.pushNamed(context, pageRoute),

          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: FlatButton.icon(
                icon: Icon(icono, color: color),
                label: Text(titulo, style: TextStyle(color: Colors.black, fontSize: 15.0)),
                onPressed: null,
              ),
              subtitle: textoConNumeroDeDocumentos(context),
            ),
          ),
        ),

      ),
    );


  }








}