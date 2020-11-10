import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:transparent_image/transparent_image.dart';


import 'package:sena_app/src/models/producto_model.dart';
import 'package:sena_app/src/utils/utils.dart' as utils;



class ListaModificarProductoPage extends StatefulWidget {
  @override
  _ListaModificarProductoPageState createState() => _ListaModificarProductoPageState();
}


// State
class _ListaModificarProductoPageState extends State<ListaModificarProductoPage> {

  // Nombre de la colección en Firestore
  String collectionName = 'productos';

  



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
      title: Text('Modificar Producto'),
    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return Container(
      
      child: Column(
      
        children: <Widget>[
        
          // Lista de Productos
          Flexible(
            child: _buildListaProductos(context),
          ),

        ],
      ),

    );

  }


  // _buildListaProductos Widget
  Widget _buildListaProductos(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _getProductos(),
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


  // _getProductos Método
  _getProductos() {

    return Firestore.instance
      .collection(collectionName)
      .orderBy('nombre')
      .snapshots();

  }


  // _buildLista Widget
  Widget _buildLista(BuildContext context, List<DocumentSnapshot> snapshot) {

    return GridView.count(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      
      crossAxisCount: 2,
      childAspectRatio: 0.84,
      padding: EdgeInsets.all(4.0),

      children: snapshot.map((data) => _buildListaItems(context, data)).toList(),
    );

  }


  // _buildListaItems Widget
  Widget _buildListaItems(BuildContext context, DocumentSnapshot data) {
        
    // Instancia del producto con sus valores 
    final producto = ProductoModel.fromSnapshot(data);

    // Tamaño Pantalla
    final _screenSize = MediaQuery.of(context).size;

    // Carta que se crea, con imagen e info por producto
    // Está en InkWell y al clickear lleva a los detalles del producto
    return InkWell(

      child: Card(

        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),

        elevation: 2.0,
        // Para los bordes de la card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        // Para evitar puntas cuadradas en la parte superior de la card
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // textDirection: TextAlign.start,

          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // Imagen

            // FadeInImage(
            //   image: NetworkImage(producto.imagenUrl),
            //   placeholder: AssetImage('assets/images/loading.jpg'),
            //   height: _screenSize.height * 0.27,
            //   // height: _screenSize.height * 0.26, // Visualizar en emulador
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),

            Image.network(
              producto.imagenUrl,
              width: double.infinity,
              height: _screenSize.height * 0.25, // Visualizar en emulador
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null)
                  return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),


            // Container(
            //   child: Hero(
            //     tag: producto.imagenUrl,

            //     child: FadeInImage(
            //       image: NetworkImage(producto.imagenUrl),
            //       placeholder: AssetImage('assets/images/loading.jpg'),
            //       height: _screenSize.height * 0.27,
            //       // height: _screenSize.height * 0.26, // Visualizar en emulador
            //       width: double.infinity,
            //       fit: BoxFit.cover,
            //     ),


            //     // child: FadeInImage(

            //     //   image: CachedNetworkImageProvider(producto.imagenUrl),
            //     //   placeholder: AssetImage('assets/images/loading.jpg'),
            //       // height: _screenSize.height * 0.27,
            //       // // height: _screenSize.height * 0.26, // Visualizar en emulador
            //     //   width: double.infinity,
            //     //   fit: BoxFit.fill,


                  
            //       // image: NetworkImage(producto.imagenUrl),
            //       // placeholder: AssetImage('assets/images/loading.jpg'),
            //       // height: _screenSize.height * 0.27,
            //       // // height: _screenSize.height * 0.26, // Visualizar en emulador
            //       // width: double.infinity,
            //       // fit: BoxFit.fill,
            //   ),
            // ),



              // child: FadeInImage(
              //   image: NetworkImage(producto.imagenUrl),
              //   placeholder: AssetImage('assets/images/loading.jpg'),
              //   height: _screenSize.height * 0.27,
              //   // height: _screenSize.height * 0.26, // Visualizar en emulador
              //   width: double.infinity,
              //   fit: BoxFit.fill,
              // ),


            

            
            // // Imagen
            // Container(

            //   child: FadeInImage(
            //     image: NetworkImage(producto.imagenUrl),
            //     placeholder: AssetImage('assets/images/loading.jpg'),
            //     height: _screenSize.height * 0.27,
            //     // height: _screenSize.height * 0.26, // Visualizar en emulador
            //     width: double.infinity,
            //     fit: BoxFit.fill,
            //   ),

            // ),

            // Título
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0, top: 9.0),
                    child: Text(
                      '${producto.nombre}', 
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.0), 
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                  ),
                ),
              ],
            ),

            // Precio
            Padding(
              padding: const EdgeInsets.only(left: 7.0, top: 4.0),
              child: Text(
                // Para dar formato al número
                '\$ ${utils.formatearNumero(producto.precio)}',
                style: TextStyle(fontSize: 16.0), 
                textAlign: TextAlign.justify,
              ),
            ),


          ],

        ),

        
      ),

      onTap: (){
        
        // Abrimos la page de modificarproductopage y enviamos el producto
        Navigator.pushNamed(context, '/modificarproductopage', arguments: producto);

      },

    );










    // // Carta que se crea, con imagen e info por producto
    // // Está en InkWell y al clickear lleva a los detalles del producto
    // return InkWell(
    //   child: Card(
    //     elevation: 10.0,
    //     child: Stack(

    //       children: <Widget>[

    //         // CircularProgress Mientras cargan las imágenes
    //         Center(
    //           child: CircularProgressIndicator(
    //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    //           ),
    //         ),


    //         // Contenido de la Card, imagen e info
    //         Column(

    //           // crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[

    //             Container(
    //               padding: EdgeInsets.only(bottom: _screenSize.height * 0.004),
    //               child: FadeInImage.memoryNetwork(
    //                   image: producto.imagenUrl,
    //                   placeholder: kTransparentImage,
    //                   height: _screenSize.height * 0.24,
    //                   width: double.infinity,
    //                   fit: BoxFit.cover,
    //                 ),
    //             ),

    //             Text('${producto.nombre} - ${producto.precio.truncate()}'),


    //           ],

    //         ),

    //       ],

          
    //     ),
    //   ),

    //   onTap: (){

        // // Abrimos la page de modificarproductopage y enviamos el producto
        // Navigator.pushNamed(context, '/modificarproductopage', arguments: producto);

    //   },

    // );

  }






}

















