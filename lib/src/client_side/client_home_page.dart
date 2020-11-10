import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:sena_app/src/utils/utils.dart' as utils;
import 'package:sena_app/src/models/producto_model.dart';



class ClientHomePage extends StatefulWidget {
  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}


// State
class _ClientHomePageState extends State<ClientHomePage> {

  // Nombre de la colección en Firestore
  String collectionName = 'productos';
  

  // build
  @override
  Widget build(BuildContext context) {

    // Para cambiar color de system navigation bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffff3a5a), // navigation bar color
      statusBarColor: Color(0xffff3a5a), // status bar color
    ));


    return Scaffold(

      appBar: _appBarWidget(),

      drawer: _menuDrawerWidget(),

      body: _bodyWidget(context),



    );
  }


  // _appBar Widget
  Widget _appBarWidget() {

    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          // Icono Drawer Menu
          icon: Icon(FontAwesomeIcons.bars),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      backgroundColor: Color(0xffff3a5a),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YUKA TiendApp', // Título de App
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: <Widget>[
        // Icono de comprar
        IconButton(
            icon: Icon(FontAwesomeIcons.shoppingCart),
            onPressed: () => Navigator.pushNamed(context, '/comprarpage'),
        ),
      ],
    );

  }


  // _menuDrawer Widget
  Widget _menuDrawerWidget() {

    return Drawer(
      child: ListView(
        children: <Widget>[


          // Header del Menu Drawer
          UserAccountsDrawerHeader(
            accountName: Text('YUKA', style: TextStyle(color: Colors.white, fontSize: 18.0)),
            accountEmail: Text('App Tienda Virtual'),
            currentAccountPicture: CircleAvatar(
              minRadius: 80.0,
              backgroundColor: Colors.blueGrey,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpg'),
                minRadius: 80.0,
              ),
            ),
            decoration: BoxDecoration(color: Color(0xffff3a5a)),
          ),


          // Creamos Los ListTile

          // Catálogo
          InkWell(
            onTap: () => Navigator.pop(context),
            child: ListTile(
              title: Text('Catálogo'),
              leading: Icon(FontAwesomeIcons.home, color: Color(0xffff3a5a)),
            ),
          ),

          // Productos
          utils.itemListTile(context, 'Productos', '/listaproductospage', Icons.local_offer, Colors.lightBlueAccent),

          // Categorías
          utils.itemListTile(context, 'Categorías', '/listacategoriaspage', Icons.dashboard, Colors.teal),

          // Divider
          Divider(),

          // Quienes Somos
          utils.itemListTile(context, 'Quienes Somos', '/quienessomospage', FontAwesomeIcons.solidQuestionCircle, Colors.lightGreen),

          // Cerrar Sesión
          InkWell(
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
            child: ListTile(
              title: Text('Cerrar Sesión'),
              leading: Icon(Icons.exit_to_app, color: Colors.redAccent,),
            ),
          ),


        ],
      ),
    );


  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    // Tamaño de pantalla
    final screenSize = MediaQuery.of(context).size;


    // Se usa CustomScrollView para poder integrar Widgets con el GridView
    return CustomScrollView(

      slivers: <Widget>[

        // Carousel de imagenes - Sliders
        SliverList(
          delegate: SliverChildListDelegate([
            _imageCarousel(screenSize),
          ]),

        ),

        // SizedBox
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0,),
          ]),
        ),

        // Text de Todos los productos
        SliverList(
          delegate: SliverChildListDelegate([
            // Text de Todos los productos
           _textTodosLosProductos(screenSize),
          ]),
        ),

        // GridView con los productos
        SliverGrid.count(
          crossAxisCount: 1,
          children: <Widget> [_buildProductosWidget(context)],
        ),


      ],

    ); 


  }


  // _imageCarousel Widget
  // Widget para mostrar Carousel de imagenes, el slider
  Widget _imageCarousel(final screenSize) {

    return Container(

      height: screenSize.height * 0.32,
      child: Carousel(

        boxFit: BoxFit.cover,
        images: [
          // Image.asset('assets/images/logo.jpg', fit: BoxFit.fill),
          AssetImage('assets/images/slider-1.jpg'),
          AssetImage('assets/images/slider-2.jpg'),
          AssetImage('assets/images/slider-3.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        dotBgColor: Colors.transparent,
        dotIncreasedColor: Color(0xffff3a5a),
        dotSize: 5.5,
        indicatorBgPadding: 4.0,
        autoplayDuration: Duration(milliseconds: 4000),
        animationDuration: Duration(milliseconds: 2000), // Duración animación

      ),

    );


  }


  // _textTodosLosProductos
  // Texto de todos los productos que me lleva a la lista
  Widget _textTodosLosProductos(final screenSize) {

    return Padding(

      padding: const EdgeInsets.only(top: 1.0, right: 1.0, bottom: 1.0),
      child: FlatButton(
        onPressed: () => Navigator.pushNamed(context, '/listaproductospage'),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Todos los Productos', 
            style: TextStyle(fontSize: screenSize.height * 0.030, fontWeight: FontWeight.bold),
          ),
        ),
      ),

    );

  }



  // _buildProductosWidget
  Widget _buildProductosWidget(BuildContext context) {

    return Container(
      
      child: Column(
      
        children: <Widget>[
        
          // Lista de Productos
          Flexible(
            child: _buildListaProductos(context),
          ),

          // _buildListaProductos(context),

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

    // Tamaño Pantalla
    final _screenSize = MediaQuery.of(context).size;

    // Altura de la card
    final double cardHeight = (_screenSize.height) / 2.6;

    // Ancho de la card
    final double cardWidth = _screenSize.width / 2.1;

    return GridView.count(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

      crossAxisCount: 2,
      // childAspectRatio: 0.82,
      childAspectRatio: 0.84,
      padding: EdgeInsets.all(4.0),
      // padding: EdgeInsets.only(bottom: 30.0),
      
      
      children: snapshot.map((data) => _buildListaItems(context, data)).toList(),
    );

  }


  // // _buildLista Widget
  // Widget _buildLista(BuildContext context, List<DocumentSnapshot> snapshot) {

  //   return GridView(
  //     // shrinkWrap: true,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      
  //     children: snapshot.map((data) => _buildListaItems(context, data)).toList(),
  //   );

  // }


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
        elevation: 2.0,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // textDirection: TextAlign.start,

          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // Imagen
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

           

            // FadeInImage(
            //   image: NetworkImage(producto.imagenUrl),
            //   placeholder: AssetImage('assets/images/loading.jpg'),
            //   height: _screenSize.height * 0.27,
            //   // height: _screenSize.height * 0.26, // Visualizar en emulador
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),



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





        // child: Column(

        //   // crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[

        //     Container(
        //       padding: EdgeInsets.only(bottom: _screenSize.height * 0.004),

        //       child: FadeInImage(
        //         image: NetworkImage(producto.imagenUrl),
        //         placeholder: AssetImage('assets/images/loading.jpg'),
        //         height: _screenSize.height * 0.24,
        //         width: double.infinity,
        //         fit: BoxFit.cover,
        //       ),




        //     ),

        //     Text('${producto.nombre} - ${producto.precio.truncate()}'),


        //   ],

        // ),

      ),

      onTap: (){
        
        // Navegamos a la otra pantalla y mandamos el objeto producto al que dimos clic
        // Con todos sus argumentos
        Navigator.pushNamed(context, '/detalleproductopage', arguments: producto);

      },

    );

  }



}