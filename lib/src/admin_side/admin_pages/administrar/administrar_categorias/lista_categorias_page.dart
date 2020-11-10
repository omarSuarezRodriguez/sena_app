import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sena_app/src/models/categoria_model.dart';



class ListaCategoriasPage extends StatefulWidget {
  @override
  _ListaCategoriasPageState createState() => _ListaCategoriasPageState();
}


// State
class _ListaCategoriasPageState extends State<ListaCategoriasPage> {

  // Nombre de la colección en Firestore
  String collectionName = 'categorias';



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
      title: Text('Categorías'),
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
            'Lista de Categorías',
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

      child: InkWell(
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.circular(5.0),
          ),

          child: ListTile(title: Text(categoria.nombre)),

        ),
        onTap: () {
          // Navegamos a la otra pantalla y mandamos el objeto producto al que dimos clic
          // Con todos sus argumentos
          Navigator.pushNamed(context, '/listaproductoscategoria', arguments: categoria.nombre);
        },
      ),

    );

  }










}