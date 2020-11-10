import 'package:flutter/material.dart';

// Logins
import 'src/login/login.dart';

// Admin side imports
import 'src/admin_side/admin_home_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/administrar_productos_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/lista_productos_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/detalle_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/pantalla_completa_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/agregar_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/lista_modificar_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/modificar_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_productos/eliminar_producto_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/administrar_categorias_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/lista_categorias_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/lista_productos_categoria_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/agregar_categoria_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/modificar_categoria_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_categorias/eliminar_categoria_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_clientes/administrar_clientes_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_clientes/lista_clientes_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_clientes/agregar_cliente_page.dart';
import 'src/admin_side/admin_pages/administrar/administrar_clientes/modificar_cliente_page.dart';
import 'package:sena_app/src/admin_side/admin_pages/administrar/administrar_clientes/eliminar_cliente_page.dart';

// Client side imports
import 'src/client_side/client_home_page.dart';
import 'src/client_side/client_pages/comprar_page.dart';
import 'src/client_side/client_pages/quienes_somos_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Título App
      title: 'YUKA TiendApp',

      // Quitar Banner
      debugShowCheckedModeBanner: false,
      

      // ===========================================================
      // ======================== < RUTAS > ========================
      // ===========================================================

      //
      //
      //

      // Ruta Inicial - Main
      // Login es la page inicial
      initialRoute: '/',

      //
      //
      //

      // Routes - Rutas
      routes: {

        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //

        // ========== < MAIN > ==========

        // Main - Es el login
        '/': (context) => SafeArea(child: LoginPage()),

        // ========= < /MAIN > ==========

        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //

        // ===========================================
        // ========== < ADMIN side Routes > ==========
        // ===========================================

        // HOMEPAGE
        '/homepageadmin': (context) => SafeArea(child: AdminHomePage()),

        // ===== < Administrar > =====
        // ===========================

        //
        //
        //

        // == < Productos > ==

        // Administrar Productos, ruta de Productos en admin_side Administrar
        '/administrarproductospage': (context) => SafeArea(child: AdministrarProductosPage()),

        // Lista de Productos, ruta de Lista de Productos en admin_side Administrar
        '/listaproductospage' : (context) => SafeArea(child: ListaProductosPage()),

        // Detalle de cada Producto, ruta de Detalle de cada Producto en admin_side Administrar
        '/detalleproductopage' : (context) => SafeArea(child: DetalleProductoPage()),

        // Pantalla completa de imagen de producto,
        // ruta de Pantalla completa de cada Producto en admin_side Administrar
        '/pantallacompletaproductopage' : (context) => SafeArea(child: PantallaCompletaProductoPage()),

        // Agregar Productos, ruta de Agregar Productos en admin_side Administrar
        '/agregarproductopage': (context) => SafeArea(child: AgregarProductoPage()),

        // Lista Modificar Productos, ruta de Lista para Modificar Productos en admin_side Administrar
        '/listamodificarproductopage': (context) => SafeArea(child: ListaModificarProductoPage()),

        // Modificar Productos, ruta de Modificar Productos en admin_side Administrar
        '/modificarproductopage': (context) => SafeArea(child: ModificarProductoPage()),

        // Eliminar Producto, ruta de Eliminar Producto en admin_side Administrar
        '/eliminarproductopage' : (context) => SafeArea(child: EliminarProductoPage()),

        // == < /Productos > ==

        //
        //
        //

        // == < Categorías > ==

        // Administrar Categorías, ruta de Categorías en admin_side Administrar
        '/administrarcategoriaspage': (context) => SafeArea(child: AdministrarCategoriasPage()),

        // Lista de Categorias, ruta de Lista de Categorías en admin_side Administrar
        '/listacategoriaspage' : (context) => SafeArea(child: ListaCategoriasPage()),

        // Lista de Productos de una categoria, ruta de Lista de productos de una Categoría en admin_side Administrar
        '/listaproductoscategoria' : (context) => SafeArea(child: ListaProductosCategoriaPage()),

        // Agregar Categoría, ruta de Agregar Categoría en admin_side Administrar
        '/agregarcategoriapage' : (context) => SafeArea(child: AgregarCategoriaPage()),

        // Modificar Categoría, ruta de Modificar Categoría en admin_side Administrar
        '/modificarcategoriapage' : (context) => SafeArea(child: ModificarCategoriaPage()),

        // Eliminar Categoría, ruta de Eliminar Categoría en admin_side Administrar
        '/eliminarcategoriapage' : (context) => SafeArea(child: EliminarCategoriaPage()),

        // == < /Categorías > ==

        //
        //
        //

        // == < Clientes > ==

        // Administrar Clientes, ruta de Clientes en admin_side Administrar
        '/administrarclientespage' : (context) => SafeArea(child: AdministrarClientesPage()),

        // Lista de Clientes, ruta de Lista de clientes en admin_side Administrar
        '/listaclientespage' : (context) => SafeArea(child: ListaClientesPage()),

        // Agregar Cliente, ruta de Agregar Cliente en admin_side Administrar
        '/agregarclientepage' : (context) => SafeArea(child: AgregarClientePage()),

        // Modificar Cliente, ruta de Modificar Cliente en admin_side Administrar
        '/modificarclientepage' : (context) => SafeArea(child: ModificarClientePage()),

        // Eliminar Cliente, ruta de Eliminar Cliente en admin_side Administrar
        '/eliminarclientepage' : (context) => SafeArea(child: EliminarClientePage()),

        // == < /Clientes > ==

        //
        //
        //

        // ==== < /Administrar > =====
        // ===========================
        
        // ===========================================
        // ========= < /ADMIN side Routes > ==========
        // ===========================================

        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //

        //============================================
        // ========== < USER side Routes > ===========
        //============================================

        // HOMEPAGE, el CATALOGO
        // HomePageClient , ruta de HomePage del Cliente en client_side
        '/homepageclient': (context) => SafeArea(child: ClientHomePage()),

        // QuienesSomosPage , ruta de Quines Somos del Cliente en client_side 
        '/quienessomospage': (context) => SafeArea(child: QuienesSomosPage()),

        // ComprarPage , ruta de Comprar del Cliente en client_side 
        '/comprarpage': (context) => SafeArea(child: ComprarPage())

        //============================================
        // ========= < /USER side Routes > ===========
        //============================================

        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //

      },

      //
      //
      //

      // ===========================================================
      // ======================= < /RUTAS > ========================
      // ===========================================================

    );
  }
}