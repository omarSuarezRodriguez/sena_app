import 'package:flutter/material.dart';

import 'package:sena_app/src/client_side/client_widgets/client_widgets.dart' as clientWidgets;

class QuienesSomosPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBarWidget(context),

      body: _bodyWidget(context),

      
    );
  }


  // _appBar Widget
  Widget _appBarWidget(BuildContext context) {

    return AppBar(
      //Con esta configuración podemos implementar boton para atras en AppBar
      automaticallyImplyLeading: true,
      backgroundColor: Color(0xffff3a5a),
      title: Text('Quienes Somos'),

    );

  }


  // _body Widget
  Widget _bodyWidget(BuildContext context) {

    return Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xffff3a5a), Color(0xffff3a5a)]),
            ),
          ),
          _buildHeader(context),
          
        ],
      );

  }



  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      height: 440.0,
      // height: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "YUKA Calzado",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 270.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            
                            subtitle: clientWidgets.textoQuienesSomos(),

                          ),
                        ),
                        
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage("assets/images/logo.jpg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}