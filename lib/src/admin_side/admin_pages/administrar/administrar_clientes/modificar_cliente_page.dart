import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sena_app/src/models/cliente_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class ModificarClientePage extends StatefulWidget {
  @override
  _ModificarClientePageState createState() => _ModificarClientePageState();
}


// State
class _ModificarClientePageState extends State<ModificarClientePage> {

  // Nombre de la colección en Firestore
  String collectionName = 'clientes';

  // Boolean para saber si mostrar o no el TextField para editar el cliente
  bool showTextField = false;

  // TextEditingController del TextField
  TextEditingController textEditingController = TextEditingController();

  // Cursor para saber que cliente se tiene seleccionado para editar
  ClienteModel cursorCliente;

  // Focus para el TextFormField
  FocusNode focusTextFormField = FocusNode();




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
      title: Text('Modificar Cliente')
    );


  }


  // _body Widget
  Widget _bodyWidget() {

    return Container(

      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),

      child: Column(
      
        children: <Widget>[

          // _crearEditarCliente Widget
          _crearEditarClienteWidget(),
          

          SizedBox(height: 15.0),


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


  // _crearEditarCliente Widget
  // Me muestra el TextField para editar si el boolean es true
  Widget _crearEditarClienteWidget() {

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
              labelText: 'Nombre Cliente',
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

        _actualizarInfoCliente(cursorCliente, textEditingController.text);

        utils.mostrarToastCorto(context, 'Cliente Editado', Colors.green);
  
      } else {
        utils.mostrarDialog(context, 'Error', 'Ingrese el nombre por favor.', 
        'Cerrar', 'button_2', null, null);
        focusTextFormField.requestFocus();
      }
    });

  }


  // _actualizarInfoCliente
  // Actualizar información del cliente en database
  _actualizarInfoCliente(ClienteModel cliente, String nuevoNombre) {

    // Actualizar Info del cliente en Firestore
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(cliente.reference, {'nombre' : nuevoNombre});
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
            icon: Icon(FontAwesomeIcons.pencilAlt, color: Colors.indigoAccent),
            onPressed: () => _editarCliente(cliente),
          ),
        ),

      ),

    );

  }


  // _editarCliente Método
  // Método para Editar Cliente en Firestore
  // Permite mostrar TextFormField para editar
  _editarCliente(ClienteModel cliente) {

    textEditingController.text = cliente.nombre;

    setState(() {
      showTextField = true;
      focusTextFormField.requestFocus();
      cursorCliente = cliente;
    });


  }













}