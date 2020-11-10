import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/models/categoria_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class ModificarCategoriaPage extends StatefulWidget {
  @override
  _ModificarCategoriaPageState createState() => _ModificarCategoriaPageState();
}


// State
class _ModificarCategoriaPageState extends State<ModificarCategoriaPage> {

  // Nombre de la colección en Firestore
  String collectionName = 'categorias';

  // Boolean para saber si mostrar o no el TextField para editar la categoria
  bool showTextField = false;

  // TextEditingController del TextField
  TextEditingController textEditingController = TextEditingController();

  // Cursor para saber que categoría se tiene seleccionada para editar
  CategoriaModel cursorCategoria;

  // Focus para el TextFormField
  FocusNode focusTextFormField = FocusNode();



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
      title: Text('Modificar Categoría')
    );


  }


  // _body Widget
  Widget _bodyWidget() {

    return Container(

      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),

      child: Column(
      
        children: <Widget>[

          // _crearEditarCategoria Widget
          _crearEditarCategoriaWidget(),
          

          SizedBox(height: 15.0),


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


  // _crearEditarCategoria Widget
  // Me muestra el TextField para editar si el boolean es true
  Widget _crearEditarCategoriaWidget() {

    // Si el boolean showTextField es true, muestre el TextField
    return showTextField

      ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          TextFormField(
            focusNode: focusTextFormField,
            onFieldSubmitted: (v) {
              _clickOkBotonEditar();
            },
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            autocorrect: false,
            enableSuggestions: false,
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Nombre Categoría',
            ),
          ),

          SizedBox(height: 10.0),

          // Botón para Actualizar y Cancelar
          _botonActualizarYCancelar(),




        ],
      )
      : Container();

  }


  // Muestra los botones de Actualizar Y Cancelar
  Widget _botonActualizarYCancelar() {

    return SizedBox(
      width: double.infinity,

      child: Row(
        children: <Widget>[

          RaisedButton(
            color: Color(0xff00E676),
            textColor: Colors.white,
            child: Text('Actualizar'),

            onPressed: () {

              _clickOkBotonEditar();

            },
          ),

          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
          ),

          OutlineButton(
            child: Text("Cancelar"),
            onPressed: () {
              setState(() {
                showTextField = false;
                textEditingController.text = "";
              });
            }
          )

        ],
      ),


    );

  }


  // _clickOkBotonEditar
  _clickOkBotonEditar() {

    setState(() {
      if(textEditingController.text.isNotEmpty) {

        _actualizarProductosDeCategoria(cursorCategoria.nombre, textEditingController.text);

        _actualizarInfoCategoria(cursorCategoria, textEditingController.text);



        utils.mostrarToastCorto(context, 'Categoría Editada', Colors.green);
  
      } else {
        utils.mostrarDialog(context, 'Error', 'Ingrese el nombre por favor.', 
        'Cerrar', 'button_2', null, null);
        focusTextFormField.requestFocus();
      }
    });

  }


  // _actualizarInfoCategoria
  // Actualizar información de la Categoria  en database
  _actualizarInfoCategoria(CategoriaModel categoria, String nuevoNombre) {

    // Actualizar Info de la Categoría en Firestore
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(categoria.reference, {'nombre' : nuevoNombre});
      });

    } catch (e) {
      print(e.toString());
    }

    // Redibujamos el Stateful para ocultar el TextFormField
    setState(() {
      showTextField = false;
    });

    // Vaciamos el textEditingController, es decir el TextFormField
    textEditingController.text = '';

  }


  // Actualizar info productos de categoría
  // Actualizar Productos de la categoría seleccionada para modificar
  _actualizarProductosDeCategoria(String categoria, String nuevoNombre) {

    for (var i = 0; i < listaProductos.length; i++) {

      if (categoria == listaProductos[i].data['categoria']) {

        try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(listaProductos[i].reference, {'categoria' : nuevoNombre});
      });

      } catch (e) {
        print(e.toString());
      }



      // Firestore.instance.runTransaction(
      //   (Transaction transaction) async {
      //     await transaction.delete(listaProductos[i].reference);
      //   },
      // );

    }
      
    }


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
            icon: Icon(FontAwesomeIcons.pencilAlt, color: Colors.indigoAccent),
            onPressed: () => _editarCategoria(categoria),
          ),
        ),

      ),

    );

  }


  // _editarCategoria Método
  // Método para Editar Categoría en Firestore
  // Permite mostrar TextFormField para editar
  _editarCategoria(CategoriaModel categoria) {

    textEditingController.text = categoria.nombre;

    setState(() {
      showTextField = true;
      focusTextFormField.requestFocus();
      cursorCategoria = categoria;
    });


  }













}