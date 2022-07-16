import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtotolist/models/ModelTasks.dart';
import 'package:newtotolist/widgets/notita.dart';
import 'package:newtotolist/widgets/toast.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Homepages/Homepage_Diario.dart';
import '../models/ModeloUsuarios.dart';

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: checkList(),
    );
  }
}

class checkList extends StatefulWidget {
  @override
  _checkListState createState() => _checkListState();
}

class _checkListState extends State<checkList> {

  
  ModeloUsuarios modeloUsuarios = ModeloUsuarios();
  final user= FirebaseAuth.instance.currentUser!;
  

   @override
    void initState() {
        super.initState();
        FirebaseFirestore.instance
            .collection("Usuarios")
            .doc(user.uid)
            .get()
            .then((value) {
          this.modeloUsuarios = ModeloUsuarios.fromMap(value.data());
          setState(() {});
          
        });
      }
  
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ModelTasks modelTasks = ModelTasks();
  final TextEditingController _otraactvidad = TextEditingController();
  bool checked = false;
  String? actividad;
  String? importancia;
  
  DateTime? date;
  
  TimeOfDay? time;

  String getdiaText() {
    if (date==null) {
      return 'Seleccionar mi dia';
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  String gethoraText(){
    if (time == null) {
      return 'Seleccionar hora';
    } else{
      final hours = time!.hour.toString().padLeft(2,'0');
      final minutes = time!.minute.toString().padLeft(2,'0');
      return '$hours:$minutes';
    }
  }
  
  Future _todobien() async{
    if(actividad==null){
      notaErrortoast();
    } else{
      _mandarFirestore();
    }
  }

  Future _mandarFirestore() async{
    
    if (date!=null) {
      
      if (importancia==null) {
        importancia="verde";
        } else{
          importancia = importancia;
        }

      if (time!=null) {
        time = TimeOfDay(hour: time!.hour, minute: time!.minute);
        } else{
          time = TimeOfDay(hour: 00, minute: 00);
        }
      
      print("HORA: ${time!.hour}:${time!.minute}");


      String otraactivity = "Otro";
      if (_otraactvidad.text!="") {
        setState(() {
          otraactivity = _otraactvidad.text;
        });
      } 


      if(actividad=="Otro")
      modelTasks.actividad = otraactivity;
      if(actividad!="Otro")
      modelTasks.actividad = actividad;
      modelTasks.dia = DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute).toLocal();
      modelTasks.importancia = importancia;

       await firebaseFirestore
        .collection("Usuarios")
        .doc(user.uid)
        .collection("Tasks")
        .doc()
        .set(modelTasks.toMap());

        
          Navigator.pop(context);
          taskcreadotoast();

        // if (actividad=="Otro") {
        //   if (_otraactvidad.text!="") {
        //     print("La actividad es ${_otraactvidad.text}");
        //   } else{
        //     print("pipippi");
        //   }
        // }  if(actividad!="Otro"){
        //   print("La actividad es $actividad");
        // }
      
      print("La importancia del documento es $importancia");
    } else{
      notadiaErrortoast();
    }

  }

  FocusNode textSecondFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text(
          "Actividades",
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
                physics: BouncingScrollPhysics(),
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
                              "¿Que haras mañana?",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RadioListTile<String>(
                              groupValue: actividad,
                              title: Text(
                                "Trabajo",
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  actividad="Trabajo";
                                  print(actividad);
                                  _otraactvidad.text="";
                                  
                                });
                              },
                              value: "Trabajo",
                            ),
                            RadioListTile<String>(
                              groupValue: actividad,
                              title: Text(
                                "Examen",
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  actividad="Examen";
                                  print(actividad);
                                  _otraactvidad.text="";
                                  
                                });
                              },
                              value: "Examen",
                            ),
                            RadioListTile<String>(
                              groupValue: actividad,
                              title: Text(
                                "Cita medica",
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  actividad="Cita medica";
                                  print(actividad);
                                  _otraactvidad.text="";
                                  
                                });
                              },
                              value: "Cita medica",
                            ),
                            RadioListTile<String>(
                              groupValue: actividad,
                              title: Text(
                                "Salida",
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  actividad="Salida";
                                  print(actividad);
                                  _otraactvidad.text="";
                                  
                                });
                              },
                              value: "Salida",
                            ),
                            RadioListTile<String>(
                              groupValue: actividad,
                              title: Text(
                                "Otro",
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  actividad="Otro";
                                  print(actividad);
                                  FocusScope.of(context).requestFocus(textSecondFocusNode);
                                });
                              },
                              value: "Otro",
                            ),
                            TextFormField(
                              controller: _otraactvidad,
                              enabled: actividad=="Otro"? true:false,
                              autofocus: actividad=="Otro"? true:false,
                              focusNode: textSecondFocusNode,
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Text(
                                  "Importancia ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "(opcional)",
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                ),
                              ],
                            ),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                
                                Container(
                                    height: 50,
                                    width: 50,
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
                                        importancia  = "rojo";
                                        print(importancia);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
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
                                        importancia  = "naranja";
                                        print(importancia);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
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
                                        importancia  = "amarillo";
                                        print(importancia);
                                      });
                                    },
                                    child: Container(
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
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
                                        importancia  = "verde";
                                        print(importancia);
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

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dia",
                                  style: TextStyle(
                                    fontSize: 18
                                  ),),

                                ElevatedButton(
                                  onPressed: (){
                                    _fechaconfirm(context);
                                  }, 
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                       getdiaText(),
                                        style: TextStyle(fontSize: 15),)),
                                  )),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Hora ",
                                      style: TextStyle(
                                        fontSize: 18
                                      ),),
                                      Text(
                                  "(opcional)",
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                ),
                                  ],
                                ),

                                ElevatedButton(
                                  onPressed: (){
                                    _horaconfirm(context);
                                  }, 
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        gethoraText(),
                                        style: TextStyle(fontSize: 15),)),
                                  )),
                              ],
                            ),
                            SizedBox(height: 90,)
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
      floatingActionButton:
         
        Container(
          padding: EdgeInsets.only(left: 45),
          height: 80,
           width: double.infinity,
          child: Align(
            child: FloatingActionButton.extended(
              onPressed: () {
                _todobien();
               },
              backgroundColor: Color(0xffff96060),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
              label: Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Center(
                  child: Text(
                    "Crear actividad",
                    style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 2.2,
                    color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
  
Future _fechaconfirm(BuildContext context) async{
      final initialDate = DateTime.now().toLocal();
      final newdate = await showDatePicker(
              context: context, 
              initialDate: date?? initialDate, 
              firstDate: DateTime(DateTime.now().year), 
              lastDate: DateTime(DateTime.now().year+5));
      if (newdate == null) return ;
      setState(() {
        date = newdate;
      });
    }

Future _horaconfirm(BuildContext context) async{
  final initialtime = TimeOfDay(hour: TimeOfDay.hoursPerDay, minute: TimeOfDay.minutesPerHour);
  final newtime = await showTimePicker(
    context: context, 
    initialTime: time?? initialtime,
    );
  if(newtime==null) return;
  setState(() {
    time = newtime;
  });
}

}
