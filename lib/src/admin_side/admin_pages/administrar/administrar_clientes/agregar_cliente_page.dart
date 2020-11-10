import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sena_app/src/models/cliente_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class AgregarClientePage extends StatefulWidget {
  @override
  _AgregarClientePageState createState() => _AgregarClientePageState();
}


// State 
class _AgregarClientePageState extends State<AgregarClientePage> {

  // Llave global del Form
  final formKey = GlobalKey<FormState>();

  // Instancia del modelo del Cliente
  ClienteModel cliente = new ClienteModel();

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
      title: Text('Agregar Cliente'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[

            _crearNombre(),

            SizedBox(height: 20.0),

            _crearBotonGuardar(context),
            
          ],
        ),
      ),
    );

  }


  // _crearNombre Widget
  Widget _crearNombre() {

    return TextFormField(
      initialValue: cliente.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre del Cliente'
      ),
      validator: (value) {
        if (value.length < 2) {
          return 'Ingrese el nombre';
        } else {
          return null;
        }
      },
      onSaved: (value) => cliente.nombre = value,

    );

  }


  // _crearBoton Widget
  Widget _crearBotonGuardar(BuildContext context) {

    return RaisedButton.icon(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color(0xff00E676),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.add_circle),
      
      onPressed: () {

        // Subir/agregar
        _onPressedButtonGuardar(context);

      },

    );

  }


  // _onPressedButtonGuardar Método
  void _onPressedButtonGuardar(BuildContext context) {

    // Validar que el formulario esté correcto y con información
    if (!formKey.currentState.validate()) return;

    // Guardamos los datos del Form en las variables
    formKey.currentState.save();

    // Una vez hecho, subimos a la database
    _addClient();

    // Mostrar Toast de producto agregado
    utils.mostrarToastCorto(context, "Producto Agregado", Colors.green);

    // Cerrar page
    Navigator.of(context).pop();

  }


  // _addUser Método - Subir a la database
  void _addClient() {
    
    try {

      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          await Firestore.instance
            .collection(collectionName)
            .document()
            .setData(cliente.toJson());
        },
      );

    } catch (e) {
      print(e.toString());
    }

  }








}