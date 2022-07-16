import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newtotolist/widgets/BorrarNota.dart';

import '../models/ModeloUsuarios.dart';

class HomePageNota extends StatefulWidget {
  const HomePageNota({Key? key}) : super(key: key);

  @override
  State<HomePageNota> createState() => _HomePageNotaState();
}

class _HomePageNotaState extends State<HomePageNota> {
  
  ModeloUsuarios modeloUsuarios = ModeloUsuarios();
  final user= FirebaseAuth.instance.currentUser!;
  
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
      FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(user.uid)
        .get()
        .then((value) {
      this.modeloUsuarios = ModeloUsuarios.fromMap(value.data());
      // setState(() {});
          
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
                  .collection("Usuarios")
                  .doc(user.uid)
                  .collection("Notes")
                  .orderBy('creadoEl', ) 
                  .snapshots(),
          builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasData) {
                print("Tienes ${snapshot.data!.docs.length} tareas");
                return Container(
                  
                  child: snapshot.data!.docs.length!=0? 
                  Column(
                    children: [
                      SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Tienes ${snapshot.data!.docs.length} notas guardadas ",
                              style: GoogleFonts.familjenGrotesk(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                          ),
                          SizedBox(height: 20,),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2),
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                          final Timestamp timestamp = documentSnapshot['creadoEl'] as Timestamp;
                          final DateTime dateTime = timestamp.toDate();
                          final fecha = DateFormat('EEE, d/M').format(dateTime);
                          final hora = DateFormat('hh:mm a').format(dateTime);
                          final color = 
                                documentSnapshot["color"]=="rojo"?Color(0xfff96060)
                                :documentSnapshot["color"]=="naranja"?Colors.orange
                                :documentSnapshot["color"]=="amarillo"?Colors.amber.shade300
                                :documentSnapshot["color"]=="verde"?Colors.green
                                :documentSnapshot["color"]=="azul"? Colors.blue: Colors.blue;
                          final title =  "${documentSnapshot["nota"]}";
                          final docID = documentSnapshot.id;
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.16,
                                    width: MediaQuery.of(context).size.width*0.46,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15)),
                                        border: Border.all(
                                          width: 3,
                                            color: color)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: AutoSizeText(
                                          documentSnapshot['nota'],
                                          textAlign: TextAlign.center,
                                          maxLines: 10,
                                          maxFontSize: 20,
                                          minFontSize: 10,
                                        )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.46,
                                    decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        border: Border.all(
                                            color: color)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.attach_file,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                showDialog(context: context, builder: (_)=> 
                                                borrarNota(documentId: docID));
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              fecha,
                                              style: TextStyle(
                                                color: Colors.white
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                            ),
                              ),
                              // ElevatedButton(onPressed: (){}, child: Text("ads")),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),
                    ],
                  ):Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aun no tienes Notas ",
                                style: GoogleFonts.familjenGrotesk(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                              
                              SizedBox(height: 20,),
                              
                              Text(
                                "Vamos a crear algunas! ",
                                style: GoogleFonts.biryani(textStyle: TextStyle(letterSpacing: 4, fontSize: 18,)),),
                            ],
                          ),
                        ));
              } else{
                return const Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CircularProgressIndicator(),
                );
              }
            } ,
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       height: 10,
        //     ),
        //     taskWidget(
        //         Color(0xfff96060), "Practicar java", "9:00 AM", ),
        //     taskWidget(Colors.blue, "Almorzar", "2:00 PM"),
        //     taskWidget(Colors.green, "Clases de Ingles", "7:00 PM"),
        //     taskWidget(Color.fromARGB(255, 92, 223, 194),
        //         "Salir a correr", "6:00 am"),
        //     taskWidget(Color.fromARGB(255, 188, 226, 16),
        //         "Agendar reuniones", "4:30 pm"),
        //     taskWidget(Color.fromARGB(255, 231, 15, 134),
        //         "Revisar rubricas de evidencias", "6:00 am"),
        //   ],
        // ),
      ),
    );
  }
}