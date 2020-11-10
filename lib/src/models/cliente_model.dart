import 'package:cloud_firestore/cloud_firestore.dart';




class ClienteModel {


  // Nombre
  String nombre = '';


  // Referencia Documento
  DocumentReference reference;


  // Modelo del Cliente para instanciar
  ClienteModel({
    this.nombre,
  });


  // A Json
  toJson(){
    return {'nombre' : nombre};
  }


  // De Snapshot de Firestore
  ClienteModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data, reference: snapshot.reference);


  // De Mapa 
  ClienteModel.fromMap(Map<String, dynamic> map, {this.reference}) {
    nombre = map["nombre"];
  }






}