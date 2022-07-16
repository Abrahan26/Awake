import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newtotolist/Onboarding.dart';
import 'package:newtotolist/pages/CheckList.dart';
import 'package:newtotolist/main.dart';
import 'package:newtotolist/widgets/borrarActividad.dart';
import 'package:newtotolist/widgets/drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newtotolist/pages/AddNote.dart';

import '../models/ModeloUsuarios.dart';
import '../models/ModeloUsuarios.dart';


class HomePage_Diario extends StatefulWidget {
  const HomePage_Diario({Key? key,}) : super(key: key);
  @override
  _HomePage_DiarioState createState() => _HomePage_DiarioState();
}

class _HomePage_DiarioState extends State<HomePage_Diario> {

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

  final GlobalKey<ScaffoldState> Homepagekey = GlobalKey();
  String filterType = "today";
  DateTime today = DateTime.now();
  String taskPop = "close";
  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  CalendarController ctrlr = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hoy ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                      style:
                      TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                            .collection("Usuarios")
                            .doc(user.uid)
                            .collection("Tasks")
                            .orderBy('dia', ) 
                            .snapshots(),
                    builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot){
                        if (snapshot.hasData) {
                          print("Tienes ${snapshot.data!.docs.length} tareas");
                          return Container(
                            
                            child: snapshot.data!.docs.length!=0? 
                            Column(
                              children: [
                                
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Text(
                                        "Tienes ${snapshot.data!.docs.length} actividad(es) por terminar ",
                                        style: GoogleFonts.familjenGrotesk(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                                    ),
                                ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index){
                                    DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                    final Timestamp timestamp = documentSnapshot['dia'] as Timestamp;
                                    final DateTime dateTime = timestamp.toDate();
                                    final fecha = DateFormat('EEE, d/M').format(dateTime);
                                    final hora = DateFormat('hh:mm a').format(dateTime);
                                    final color = 
                                          documentSnapshot["importancia"]=="rojo"?Color(0xfff96060)
                                          :documentSnapshot["importancia"]=="naranja"?Colors.orange
                                          :documentSnapshot["importancia"]=="amarillo"?Colors.amber.shade300
                                          :documentSnapshot["importancia"]=="verde"?Colors.green: Colors.green;
                                    final title =  "${documentSnapshot["actividad"]}";
                                    final docID = documentSnapshot.id;
                                    
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // ElevatedButton(onPressed: (){}, child: Text("ads")),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Slidable(
                                          actionPane: SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.3,
                                          child: Container(
                                            height: 80,
                                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.03),
                                                  offset: Offset(0, 9),
                                                  blurRadius: 20,
                                                  spreadRadius: 1)
                                            ]),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: color, width: 4)),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SingleChildScrollView(
                                                          physics: BouncingScrollPhysics(),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height:MediaQuery.of(context).size.height*0.059,
                                                                width: MediaQuery.of(context).size.width*0.5,
                                                                child: AutoSizeText(
                                                                  title,
                                                                  maxFontSize: 18,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  minFontSize: 14,
                                                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          fecha,
                                                          style: TextStyle(color: Colors.grey, fontSize: 18),
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 5,
                                                      color: color,
                                                    )
                                                  ],
                                                ),
                                                Positioned(
                                                  right: 14,
                                                  bottom: 30,
                                                  child: Text(
                                                    hora,
                                                    style: TextStyle(color: color, fontSize: 15),))
                                              ],
                                            ),
                                          ),
                                          secondaryActions: [
                                            IconSlideAction(
                                              caption: "Eliminar",
                                              color: color,
                                              icon: Icons.edit,
                                              onTap: () {
                                                showDialog(context: context, builder: (_)=> 
                                                borrarActividad(documentId: docID));
                                              },
                                            )
                                          ],
                                        )
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
                                          "Aun no tienes actividades ",
                                          style: GoogleFonts.familjenGrotesk(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                                        
                                        SizedBox(height: 20,),
                                        
                                        Text(
                                          "Vamos a agendar algunas! ",
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
              ),
            ],
          ),
        ],
    );
  }
}