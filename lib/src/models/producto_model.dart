import 'package:cloud_firestore/cloud_firestore.dart';




class ProductoModel {
  String nombre;
  double precio;
  String categoria;
  bool disponible;
  String imagenUrl;
  String imagenThumbnailUrl;

  // Referencia Documento
  DocumentReference reference;


  // Modelo del Producto para instanciar
  ProductoModel({
    this.nombre = '',
    this.precio,
    this.categoria,
    this.disponible = true,
    this.imagenUrl,
    this.imagenThumbnailUrl,
  });


  // A Json
  toJson(){
    return {
      'nombre' : nombre,
      'precio' : precio,
      'categoria' : categoria,
      'disponible' : disponible,
      'imagenUrl' : imagenUrl,
      'imagenThumbnailUrl' : imagenThumbnailUrl,
    };
  }


  // De Snapshot de Firestore
  ProductoModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);


  // De Mapa 
  ProductoModel.fromMap(Map<String, dynamic> map, {this.reference}) {
    nombre = map["nombre"];
    precio = map['precio'];
    categoria = map['categoria'];
    disponible = map['disponible'];
    imagenUrl = map ['imagenUrl'];
    imagenThumbnailUrl = map ['imagenThumbnailUrl'];
  }




}