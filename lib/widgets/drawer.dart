
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Onboarding.dart';
import '../models/ModeloUsuarios.dart';


class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  final user= FirebaseAuth.instance.currentUser!;
  ModeloUsuarios modeloUsuarios = ModeloUsuarios();
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
          setState(() {});
          
        });
        // FirebaseFirestore.instance
        //     .collection("Urbanizaciones")
        //     .doc(Usuario_logeado.urbanizacion)
        //     .collection("Familias")
        //     .doc("${Usuario_logeado.familia}")
        //     .collection("Miembros")
        //     .doc(Usuario_logeado.uid)
        //     .get()
        //     .then((value) {
        //   this.familiamodel = Familiamodel.fromMap(value.data());
        //   print('MIEMBRO: ${familiamodel.arbol}');
        //   setState(() {});

        
        // });
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
        Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff292e4e), Colors.redAccent]
              )
            ),
            child: Container(
              width: double.infinity,
              height: 280.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 70,),
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png",
                      ),
                      radius: 50.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${modeloUsuarios.nombre}",
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
            
                    ],
                  ),
                ),
              )
              ),
              StreamBuilder<QuerySnapshot>(
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
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: snapshot.data!.docs.length>0?1:snapshot.data!.docs.length, 
                            shrinkWrap: true, 
                            itemBuilder: (context,index){
                              DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[0];
                              
                              final Timestamp timestamp = documentSnapshot['dia'] as Timestamp;
                              final DateTime dateTime = timestamp.toDate();
                              final fecha = DateFormat('d/M').format(dateTime);
                              final hora = DateFormat('hh:mm a').format(dateTime);
                              final color = 
                                    documentSnapshot["importancia"]=="rojo"?Color(0xfff96060)
                                    :documentSnapshot["importancia"]=="naranja"?Colors.orange
                                    :documentSnapshot["importancia"]=="amarillo"?Colors.amber.shade300
                                    :documentSnapshot["importancia"]=="verde"?Colors.green: Colors.green;
                              final title =  "${documentSnapshot["actividad"]}";
                              final docID = documentSnapshot.id;
                              //Text("${documentSnapshot["actividad"]}")
                              String getactividad(){
                                if (documentSnapshot["actividad"]== "Trabajo") {
                                  return documentSnapshot["actividad"];
                                } if (documentSnapshot["actividad"] == "Examen") {
                                  return documentSnapshot["actividad"];
                                } if (documentSnapshot["actividad"] == "Cita medica") {
                                  return "Cita";
                                } if (documentSnapshot["actividad"] == "Salida") {
                                  return documentSnapshot["actividad"];
                                } return "Otros";
                              }
                              if (documentSnapshot != null && documentSnapshot.exists) {
                                
                              return 
                                  Column(
                                    children: [
                                      
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text(
                                          "La actividad mas reciente en tu agenda es: ",
                                          style: GoogleFonts.familjenGrotesk(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                                      ),

                                    SizedBox(height: 20,),

                                      Card(
                                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                        clipBehavior: Clip.antiAlias,
                                        color: color,
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "Actividad",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      getactividad(),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(

                                                  children: <Widget>[
                                                    Text(
                                                      "Dia",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      fecha,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(

                                                  children: <Widget>[
                                                    Text(
                                                      "Tiempo",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      hora,
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                      
                                } return Container();
                              })
                          ],
                        ));
                    } else{
                      return const Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(),
                      );
                    }
                  } ,
              ),
            ],
          ),
        ],
      ),
              
    ),



  floatingActionButton:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          RaisedButton(
            onPressed: () {
                _Alertdialogconfirm(context);
              },
            color: Color(0xff292e4e),
            padding: const EdgeInsets.symmetric(horizontal: 80),
            elevation: 2,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "SALIR",
              style: TextStyle(
              fontSize: 15,
              letterSpacing: 2.2,
              color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

Future _Alertdialogconfirm(BuildContext context) async{
        
      final alertDialog = showDialog(
            context: context,
            builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(),
            title: Text("Confirmar", 
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),),
            content: Text("Desea salir del aplicativo?", 
              style: GoogleFonts.prompt(
                textStyle: TextStyle(
                  fontSize: 15,
                )),),
            actions: <Widget>[
              Wrap(
                spacing: 70,
                children: [
                  FlatButton(
                    onPressed:  (){
                    Navigator.of(context, rootNavigator: true).pop();
                      signOut(context);
                      },
                    child: Text(
                      'Si',
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Colors.green
                      ),) 
                    )),
                  FlatButton(
                    onPressed: ()=>
                    Navigator.of(context, rootNavigator: true).pop(),
                    child: Text(
                      'No', 
                      style: GoogleFonts.poppins(textStyle:TextStyle(
                        color: Colors.red,
                      ), ) 
                    )
                  ),
              ],
            )
          ],
        ));
    }

Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => onboarding()));
  }