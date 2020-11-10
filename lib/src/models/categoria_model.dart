import 'package:cloud_firestore/cloud_firestore.dart';




class CategoriaModel {


  // Nombre
  String nombre = '';

  // Imagen de la categoría
  String imagenUrl;


  // Referencia Documento
  DocumentReference reference;


  // Modelo del Cliente para instanciar
  CategoriaModel({
    this.nombre,
    this.imagenUrl,
  });


  // A Json
  toJson(){
    return {
      'nombre'    : nombre,
      'imagenUrl' : imagenUrl,
    };
  }


  // De Snapshot de Firestore
  CategoriaModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);


  // De Mapa 
  CategoriaModel.fromMap(Map<String, dynamic> map, {this.reference}) {
    nombre = map["nombre"];
    imagenUrl = map["imagenUrl"];
  }






}