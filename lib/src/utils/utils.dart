import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:toast/toast.dart';


////// FUNCIONES ///////
//////////////////////


//
// Método para saber si el valor es numérico
//
bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;

}



//
//   Mostrar un alert Dialog
//
//// SUPER CHETADO
//// SI EL button_2 es diferente de "" , usamos doble boton, si no solo 1
//// EL resto de parametros se podrían pasar en null
void mostrarDialog(BuildContext context, String title, String body,
    String button_1, String button_2, Function func_1, Function func_2) {
  AlertDialog dialog;
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog

      if (button_2 == "") {
        dialog = AlertDialog(
          title: Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text(button_1),
              onPressed: () {
                if (func_1 != null) {
                  func_1();
                } else {
                  Navigator.of(context).pop();
                }
                
              },
            ),
          ],
        );
      } else {
        dialog = AlertDialog(
          title: Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(button_1),
              onPressed: () {
                if (func_1 != null) {
                  func_1();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            FlatButton(
              child: new Text(button_2),
              onPressed: () {
                if (func_2 != null) {
                  func_1();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      }
      return dialog;
    },
  );
}



//
// Mostrar Toast duración corta
void mostrarToastCorto(BuildContext context, String mensaje, Color color) {
  Toast.show(mensaje, context,
    duration: Toast.LENGTH_SHORT,
    gravity: Toast.BOTTOM,
    backgroundColor: color,
    textColor: Colors.white);
}


// Widget itemListTile
// Permite crear un ListTile con título, ruta, icono y color de ícono
// Usando Navigator.pushNamed()
Widget itemListTile(BuildContext context, String titulo, String routePage, 
  IconData icono, Color color) {

  return ListTile(
    leading: Icon(icono, color: color),
    title: Text(titulo),
    onTap: () {
      // Administrar Productos
      Navigator.pushNamed(context, routePage);
    },
  );

}


// Formatear número para precio
String formatearNumero(double numero) {

  final formatearNumero = new NumberFormat.currency(locale: 'eu', name: '', decimalDigits: 0);

  return formatearNumero.format(numero);

}







