import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:sena_app/src/models/categoria_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class EliminarCategoriaPage extends StatefulWidget {
  @override
  _EliminarCategoriaPageState createState() => _EliminarCategoriaPageState();
}


// State
class _EliminarCategoriaPageState extends State<EliminarCategoriaPage> {

  // Nombre de la colección en Firestore
  String collectionName = 'categorias';


  // Para la lista de productos
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> listaProductos;
  final CollectionReference collectionReference =
    Firestore.instance.collection("productos");



  // initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        listaProductos = datasnapshot.documents;
      });
    });

    // _currentScreen();
  }



  // dispose
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }



  // build
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBarWidget(),

      body: _bodyWidget(),


    );
  }


  // _appBar Widget
  Widget _appBarWidget() {

    return AppBar(
      //Con esta configuración podemos implementar boton para atras en AppBar
      automaticallyImplyLeading: true,
      backgroundColor: Color(0xffff3a5a),
      title: Text('Eliminar Categoría')
    );


  }


  // _body Widget
  Widget _bodyWidget() {

    return Container(

      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),

      child: Column(
      
        children: <Widget>[

          // Título
          Center(child: Text(
            'Categorías',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xffff3a5a)))
          ),

          SizedBox(height: 20),

          // Lista de Categorías
          Flexible(
            child: _buildListaCategorias(context),
          ),

        ],
      ),

    );

  }


  // _buildListaCategorias Widget
  Widget _buildListaCategorias(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _getCategorias(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print('Nro Documentos: ${snapshot.data.documents.length}');
          return _buildLista(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );

  }


  // _getCategorias Método
  _getCategorias() {

    return Firestore.instance
    .collection(collectionName)
    .orderBy('nombre')
    .snapshots();

  }


  // _buildLista Widget
  Widget _buildLista(BuildContext context, List<DocumentSnapshot> snapshot) {

    return ListView(
      children: snapshot.map((data) => _buildListaItems(context, data)).toList(),
    );

  }


  // _buildListaItems Widget
  Widget _buildListaItems(BuildContext context, DocumentSnapshot data) {
        
    final categoria = CategoriaModel.fromSnapshot(data);

    return Padding(

      key: ValueKey(categoria.nombre),
      padding: EdgeInsets.symmetric(vertical: 8.0),

      child: Container(

        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlueAccent),
          borderRadius: BorderRadius.circular(5.0),
        ),

        child: ListTile(
          title: Text(categoria.nombre),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.trashAlt, color: Color(0xffff3a5a)),
            onPressed: () => _borrarCategoria(categoria),
          ),
        ),

      ),

    );

  }


  // _borrarCategoría Método
  // Método para eliminar de Firestore
  _borrarCategoria(CategoriaModel categoria) {

    // Botón de eliminar
    // Es el Sí en el AlertDialog
    Widget eliminarBoton = FlatButton(

      child: Text('Si'),
      onPressed: () {
        // Elimina de Firestore
        print('Hola');

        // Borrar Categoría
        Firestore.instance.runTransaction(
          (Transaction transaction) async {
            await transaction.delete(categoria.reference);
          },
        );

        // Borrar productos de categoría
        _borrarProductosDeCategoria(categoria.nombre);



        Navigator.pop(context);
        utils.mostrarToastCorto(context, 'Categoría Eliminada', Colors.green);
      }
      
      
    );


    // Botón para cancelar operación
    Widget cancelarBoton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );


    // Definir el alert Dialog para decidir si eliminar o no
    AlertDialog alert = AlertDialog(
      title: Text("Eliminar"),
      content: Text("¿Desea eliminar la Categoría?"),
      actions: [
        eliminarBoton,
        cancelarBoton,
      ],
    );


    // Mostrar en pantalla el diálogo de decisión para eliminar categoría
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }


  // Borrar Productos de la categoría seleccionada para eliminar
  _borrarProductosDeCategoria(String categoria) {

    for (var i = 0; i < listaProductos.length; i++) {

      if (categoria == listaProductos[i].data['categoria']) {

        Firestore.instance.runTransaction(
          (Transaction transaction) async {
            await transaction.delete(listaProductos[i].reference);
          },
        );

      }
      
    }


  }













}