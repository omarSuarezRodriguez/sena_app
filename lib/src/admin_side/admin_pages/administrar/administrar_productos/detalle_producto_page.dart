import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:sena_app/src/models/producto_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;




class DetalleProductoPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    // Recibimos el producto de la page de lista
    final ProductoModel producto = ModalRoute.of(context).settings.arguments;

    return Scaffold(

      appBar: _appBarWidget(producto.nombre),

      body: _bodyWidget(context, producto),

    );
  }


  // _body Widget
  Widget _bodyWidget(BuildContext context, ProductoModel producto) {

    return SingleChildScrollView(

      child: Column(
        children: <Widget>[

          _crearImagen(context, producto),
          _crearTitulo(producto),
          // _crearPrecio(),
          // _crearTexto(),

        ],
      ),

    );

  }


  // _appBar Widget
  Widget _appBarWidget(String nombreProducto) {

    return AppBar(
      //Con esta configuración podemos implementar boton para atras en AppBar
      automaticallyImplyLeading: true,
      backgroundColor: Color(0xffff3a5a),
      title: Text(nombreProducto),
    );

  }


  // _crearImagen()
  Widget _crearImagen(BuildContext context, ProductoModel producto) {

    return Hero(
      
      tag: producto.imagenUrl,
      child: GestureDetector(

        child: FadeInImage(
          image: NetworkImage(producto.imagenUrl),
          placeholder: AssetImage('assets/images/loading.jpg'),
          height: 300.0,
          // height: _screenSize.height * 0.26, // Visualizar en emulador
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        onTap: () {
          Navigator.pushNamed(context, '/pantallacompletaproductopage', arguments: producto.imagenUrl);
        },
      ),

    );

  }

  
  


  // _crearTitulo()
  Widget _crearTitulo(ProductoModel producto) {

    return SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Text('Producto: ' + producto.nombre, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    'Precio: \$ ${utils.formatearNumero(producto.precio)}',
                    style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
                  ),
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.redAccent, size: 30.0),
            Text(
              '5',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );

  }












}


