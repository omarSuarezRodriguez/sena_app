import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;
import 'package:sena_app/src/models/producto_model.dart';



class ModificarProductoPage extends StatefulWidget {
  @override
  _ModificarProductoPageState createState() => _ModificarProductoPageState();
}


// State
class _ModificarProductoPageState extends State<ModificarProductoPage> {

  // Archivo de la imagen
  File _image;

  // Llave global del Form
  final formKey = GlobalKey<FormState>();

  // Instancia de ProductoModel
  ProductoModel producto = new ProductoModel();

  // Nombre de la colección en Firestore de categorías
  String collectionNameCategorias = 'categorias';
  
  // Nombre de la colección en Firestore de productos
  String collectionNameProductos = 'productos';

  // Validador para saber si se está subiendo y activar o desactivar boton de Agregar
  bool isImageUploading = false;




  // Build del Stateful State
  @override
  Widget build(BuildContext context) {


    // Recibimos el producto seleccionado en la lista 
    ProductoModel productoRecibido = ModalRoute.of(context).settings.arguments;

    // Si productoRecibido no es null, cargue la información del producto seleccionado para editar
    if (productoRecibido != null) {
      producto = productoRecibido;
    }


    return Scaffold(

      appBar: _appBarWidget(),

      body: _bodyWidget(context),

    );
  }


  // AppBar Widget
  Widget _appBarWidget() {

    return AppBar(
      title: Text('Modificar Producto'),
      //Con esta configuración podemos implementar boton para atras en AppBar
      automaticallyImplyLeading: true,
      backgroundColor: Color(0xffff3a5a),
    );

  }


  // Body Widget
  Widget _bodyWidget(BuildContext context) {
    
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[

                _crearImagen(),
                _crearNombre(),
                _crearPrecio(),
                SizedBox(height: 25.0),
                _crearCategoria(),
                SizedBox(height: 10.0),
                _crearDisponible(),
                SizedBox(height: 20.0),
                _crearBoton(context),

              ],
            ),
          ),
        ),
    );

  }


  // _crearImagen Widget
  Widget _crearImagen() {

    // Obtener Imagen de la galería
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });

    }
    
    // El cuadro de la imagen
    return Builder(
      builder: (context) =>  Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xffff3a5a),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,

                          // child: Image.network(producto.imagenUrl, fit: BoxFit.cover,),

                          child: (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            producto.imagenUrl,
                            fit: BoxFit.fill,
                          ),


                        ),
                      ),
                    ),
                    onTap: () {
                      // Producto en pantalla completa
                      Navigator.pushNamed(context, '/pantallacompletaproductopage', arguments: producto.imagenUrl);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );



  }


  // _crearNombre Widget
  Widget _crearNombre() {

    return TextFormField(
      initialValue: producto.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      validator: (value) {
        if (value.length <2) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => producto.nombre = value,
    );

  }


  // _crearPrecio Widget
  Widget _crearPrecio() {

    return TextFormField(
      initialValue: producto.precio.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
      onSaved: (value) => producto.precio = double.parse(value),
    );

  }


  // _crearCategoria Widget
  Widget _crearCategoria() {

    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Categoría: ",
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 95.0,
        ),
        StreamBuilder(
          stream: Firestore.instance
          .collection('categorias')
          .orderBy('nombre')
          .snapshots(),
          builder:
            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                Center(
                  child: CircularProgressIndicator(),
                );
              return DropdownButton<String>(
                value: producto.categoria,
                isDense: true,
                hint: Text('Seleccione categoría'),
                onChanged: (newValue) {
                  setState(() {
                    producto.categoria = newValue;
                  });
                },



                items: snapshot.data != null
                  ? snapshot.data.documents
                    .map<DropdownMenuItem<String>>((DocumentSnapshot document) {
                      return new DropdownMenuItem<String>(
                        value:
                          document.data['nombre'].toString(),
                            child: new Container(
                              // height: 100.0,
                              //color: primaryColor,
                              child: new Text(
                                document.data['nombre'].toString(),
                              ),
                            ));
                    }).toList()
                    : DropdownMenuItem(
                      value: 'null',
                      child: new Container(
                        height: 100.0,
                        child: new Text('null'),
                      ),
                    ),
                    
              );
            },
        ),
      ],
    );

  }


  // _crearDisponible Widget
  Widget _crearDisponible() {

    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Color(0xffff3a5a),
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),

    );

  }


  // _crearBoton Widget
  Widget _crearBoton(BuildContext context) {

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Color(0xff00E676),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.add_circle),

      // Si isImageUploading es false
      onPressed: !isImageUploading
      ? () {
        // Si clickeamos el botón subimos el producto con toda la info y también a storage
        _subirProducto(context);
      }
      : null, // Desactivamos el botón si isImageUploading es true
    );

  }


  // Subir producto a Firestore y Firebase Storage
  void _subirProducto(BuildContext context) async {

    // Validar que el formulario esté correcto
    if (!formKey.currentState.validate()) return;

    // Si el formulario está correcto seguimos con el código para subir el producto


    // Guardamos los datos del formulario en la instancia del objeto ProductoModel llamado producto
      formKey.currentState.save();

      // Procedemos a subir la imagen

      // Se está subiendo la imagen, desactivamos el botón de Agregar
      setState(() {
        isImageUploading = true;
      });

      // Subimos la imagen y la guardamos en el objeto producto

      if (_image != null) {

        producto.imagenUrl = await _subirImagenStorage(context);

      }

      

      // En este punto ya toda la info está guardada en el objeto Producto, ahora subimos a Firestore
      _actualizarInformacionProducto();

      // Ya no se está subiendo la imagen
      setState(() {
        isImageUploading = false;
      });

      // _subirProductoFirestore();

      // La información del producto en consola
      print(producto.nombre);
      print(producto.precio);
      print(producto.categoria);
      print(producto.disponible);
      print('Productini Imagini: ' + producto.imagenUrl);

      // Mostramos Toast de Producto Modificado Correctamente
      utils.mostrarToastCorto(context, 'Producto Modificado', Colors.green);

      // Cerramos la page de Agregar Producto
      Navigator.of(context).pop();



  }
  

  // _subirImagenStorage
  // Subir Imagen al Storage en Firebase y retornamos la url de la imagen
  Future<String> _subirImagenStorage(BuildContext context) async{
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downloadUrl.toString();

    return url;

  }


  // _actualizarInformacionProducto
  void _actualizarInformacionProducto() {

    // Actualizar Info del producto en Firestore
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(producto.reference, {
          'nombre' : producto.nombre, 
          'precio' : producto.precio,
          'categoria' : producto.categoria,
          'disponible' : producto.disponible,
          'imagenUrl' : producto.imagenUrl,
          });
      });

    } catch (e) {
      print(e.toString());
    }

  }


  // // _subirProductoFirestore
  // // Subimos el producto al firestore cuando todo ya está correcto
  // void _subirProductoFirestore() {

  //   try {

  //     Firestore.instance.runTransaction(
  //       (Transaction transaction) async {
  //         await Firestore.instance
  //           .collection(collectionNameProductos)
  //           .document()
  //           .setData(producto.toJson());
  //       },
  //     );


  //   } catch (e) {
  //     print(e.toString());
  //   }

  // }








}
































