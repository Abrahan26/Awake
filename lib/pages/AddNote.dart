import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtotolist/models/ModelNote.dart';
import '../Homepages/Homepage_Diario.dart';
import '../models/ModeloUsuarios.dart';
import '../widgets/toast.dart';



class HomeNota extends StatefulWidget {
  @override
  _HomeNotaState createState() => _HomeNotaState();
}

class _HomeNotaState extends State<HomeNota> {

  ModeloUsuarios modeloUsuarios = ModeloUsuarios();
  final user= FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController _notacontroller = TextEditingController();
  ModelNote modelNote = ModelNote();
  String? color;

  Future postNotaFirestore() async{
    if (color==null) {
      color = "azul";
    } else{
      color = color;
    }
  
    if (_notacontroller.text!="") {
      
      modelNote.color= color;
      modelNote.nota = _notacontroller.text;
      modelNote.creadoEl = DateTime.now();

      await firebaseFirestore
        .collection("Usuarios")
        .doc(user.uid)
        .collection("Notes")
        .doc()
        .set(modelNote.toMap());

        
          Navigator.pop(context);
          notecreadotoast();
    } else{
      noteerrortoast();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text(
          "Nueva Nota",
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 30,
              color: Color(0xfff96060),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Descripcion",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: _notacontroller,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Agrega una descripcion aqui",
                                      ),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.attach_file,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Color",
                              style: TextStyle(fontSize: 18),
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                
                                Container(
                                    height: 40,
                                    width: 40,
                                  child: ElevatedButton(
                                    
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        )
                                      )
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        color  = "rojo";
                                        print(color);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        )
                                      )
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        color  = "naranja";
                                        print(color);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                  child: ElevatedButton(
                                    
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.amber[300]),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        )
                                      )
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        color  = "amarillo";
                                        print(color);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                  child: ElevatedButton(
                                    
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.green),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        )
                                      )
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        color  = "verde";
                                        print(color);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        )
                                      )
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        color  = "azul";
                                        print(color);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
                              ),
                              onPressed: (){
                                postNotaFirestore();
                              }, 
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Agregar Tarea",
                                    style: TextStyle(fontSize: 18),)),
                              )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
