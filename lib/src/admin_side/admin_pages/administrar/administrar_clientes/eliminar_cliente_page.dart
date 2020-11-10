import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/models/cliente_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class EliminarClientePage extends StatefulWidget {
  @override
  _EliminarClientePageState createState() => _EliminarClientePageState();
}


// State
class _EliminarClientePageState extends State<EliminarClientePage> {

  // Nombre de la colección en Firestore
  String collectionName = 'clientes';



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
      title: Text('Eliminar Cliente')
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
            'Clientes',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xffff3a5a)))
          ),

          SizedBox(height: 20),

          // Lista de Clientes
          Flexible(
            child: _buildListaClientes(context),
          ),

        ],
      ),

    );

  }


  // _buildListaClientes Widget
  Widget _buildListaClientes(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _getClientes(),
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


  // _getClientes Método
  _getClientes() {

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
        
    final cliente = ClienteModel.fromSnapshot(data);

    return Padding(

      key: ValueKey(cliente.nombre),
      padding: EdgeInsets.symmetric(vertical: 8.0),

      child: Container(

        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlueAccent),
          borderRadius: BorderRadius.circular(5.0),
        ),

        child: ListTile(
          title: Text(cliente.nombre),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.trashAlt, color: Color(0xffff3a5a)),
            onPressed: () => _borrarCliente(cliente),
          ),
        ),

      ),

    );

  }


  // _borrarCliente Método
  // Método para eliminar de Firestore
  _borrarCliente(ClienteModel cliente) {

    // Botón de eliminar
    // Es el Sí en el AlertDialog
    Widget eliminarBoton = FlatButton(

      child: Text('Si'),
      onPressed: () {
        // AGREGAR!!!!!!!!!!!!!!!!!
        print('Hola');
        Firestore.instance.runTransaction(
          (Transaction transaction) async {
            await transaction.delete(cliente.reference);
          },
        );
        Navigator.pop(context);
        utils.mostrarToastCorto(context, 'Cliente Eliminado', Colors.green);
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
      content: Text("¿Desea eliminar el cliente?"),
      actions: [
        eliminarBoton,
        cancelarBoton,
      ],
    );


    // Mostrar en pantalla el diálogo de decisión para eliminar cliente
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }













}