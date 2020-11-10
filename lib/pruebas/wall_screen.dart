import 'package:sena_app/pruebas/fullscreen_image.dart'; // Fullscreen
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';



class WallScreen extends StatefulWidget {
  
  @override
  _WallScreenState createState() => new _WallScreenState();
}


// State
class _WallScreenState extends State<WallScreen> {
  
  

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
    Firestore.instance.collection("productos");

  
  

  // initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });

    // _currentScreen();
  }


  // dispose
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }


  // build
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Wallfy"),
        ),

        body: wallpapersList != null

          ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 0.82,
            ), 
            itemCount: wallpapersList.length,
            

            itemBuilder: (context, i){

              String imgPath = wallpapersList[i].data['imagenUrl'];
              String nombre = wallpapersList[i].data['nombre'];

              return Container(
                child: InkWell(
                  child: Column(
                    children: <Widget>[
                      
                      Image(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.cover,
                      ),

                      Text(nombre),

                    ],
                  ),
                  onTap: () {},
                ),
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: NetworkImage(imgPath),
                //   ),
                // ),
              );


              // return Material(
              //   elevation: 8.0,
              //   borderRadius: BorderRadius.all(new Radius.circular(8.0)),
              //   child: InkWell(
              //     onTap: (){},
              //     child: Hero(
              //       tag: imgPath,
              //       child: FadeInImage(
              //         image: new NetworkImage(imgPath),
              //         fit: BoxFit.cover,
              //         placeholder: new AssetImage("assets/images/no-image.jpg"),
              //       ),
              //     ),
              //   ),
              // );

            },
          )

          : new Center(
              child: new CircularProgressIndicator(),
            ));



        // body: wallpapersList != null
        //   ? new StaggeredGridView.countBuilder(
        //       padding: const EdgeInsets.all(8.0),
        //       crossAxisCount: 4,
        //       itemCount: wallpapersList.length,
        //       itemBuilder: (context, i) {
        //         String imgPath = wallpapersList[i].data['imagenUrl'];
        //         return new Material(
                  
        //           elevation: 8.0,
        //           borderRadius:
        //               new BorderRadius.all(new Radius.circular(8.0)),
        //           child: new InkWell(
        //             // onTap
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   new MaterialPageRoute(
        //                       builder: (context) =>
        //                           new FullScreenImagePage(imgPath)));
        //             },
        //             child: new Hero(
        //               tag: imgPath,
        //               child: new FadeInImage(
        //                 image: new NetworkImage(imgPath),
        //                 fit: BoxFit.cover,
        //                 placeholder: new AssetImage("assets/images/no-image.jpg"),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       staggeredTileBuilder: (i) =>
        //           new StaggeredTile.count(2, i.isEven ? 2 : 3),
        //       mainAxisSpacing: 8.0,
        //       crossAxisSpacing: 8.0,
        //     )
        //   : new Center(
        //       child: new CircularProgressIndicator(),
        //     ));
  }



  // build
  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //       appBar: new AppBar(
  //         title: new Text("Wallfy"),
  //       ),
  //       body: wallpapersList != null
  //           ? new StaggeredGridView.countBuilder(
  //               padding: const EdgeInsets.all(8.0),
  //               crossAxisCount: 4,
  //               itemCount: wallpapersList.length,
  //               itemBuilder: (context, i) {
  //                 String imgPath = wallpapersList[i].data['imagenUrl'];
  //                 return new Material(
  //                   elevation: 8.0,
  //                   borderRadius:
  //                       new BorderRadius.all(new Radius.circular(8.0)),
  //                   child: new InkWell(
  //                     // onTap
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           new MaterialPageRoute(
  //                               builder: (context) =>
  //                                   new FullScreenImagePage(imgPath)));
  //                     },
  //                     child: new Hero(
  //                       tag: imgPath,
  //                       child: new FadeInImage(
  //                         image: new NetworkImage(imgPath),
  //                         fit: BoxFit.cover,
  //                         placeholder: new AssetImage("assets/images/no-image.jpg"),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               staggeredTileBuilder: (i) =>
  //                   new StaggeredTile.count(2, i.isEven ? 2 : 3),
  //               mainAxisSpacing: 8.0,
  //               crossAxisSpacing: 8.0,
  //             )
  //           : new Center(
  //               child: new CircularProgressIndicator(),
  //             ));
  // }










}