import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sena_app/src/models/cliente_model.dart';



class ListaClientesPage extends StatefulWidget {
  @override
  _ListaClientesPageState createState() => _ListaClientesPageState();
}


// State
class _ListaClientesPageState extends State<ListaClientesPage> {

  // Nombre de la colección en Firestore
  String collectionName = 'clientes';



  // build
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
      title: Text('Clientes'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return Container(

      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),

      child: Column(
      
        children: <Widget>[

          // Título
          Center(child: Text(
            'Lista de Clientes',
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

        child: ListTile(title: Text(cliente.nombre)),

      ),

    );

  }










}