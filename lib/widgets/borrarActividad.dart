import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtotolist/widgets/toast.dart';

import '../models/ModeloUsuarios.dart';

class borrarActividad extends StatefulWidget {

  final String documentId;

  borrarActividad({
    required this.documentId
  });

  @override
  State<borrarActividad> createState() => _borrarActividadState();
}

class _borrarActividadState extends State<borrarActividad> {

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
    return AlertDialog(
            shape: RoundedRectangleBorder(),
            title: Text("Confirmar", 
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),),
            content: Text("¿Estas seguro que quieres borrar esa actividad?", 
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
                    borraractividadFirestore();
                      },
                    child: Text(
                      'Si',
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold
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
        );
  }
  Future borraractividadFirestore() async{
    final docuser = FirebaseFirestore.instance
                    .collection("Usuarios")
                    .doc(modeloUsuarios.uid)
                    .collection("Tasks")
                    .doc(widget.documentId);

                  docuser.delete();

      actividadborrartoast();
  }
}