import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void registerErrortoast() =>
  Fluttertoast.showToast(
    msg: "Porfavor ingrese su correo y contraseña correctamente",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 12
 );

 void registernombreErrrotoast() =>
  Fluttertoast.showToast(
    msg: "Primero ingresemos nuestro usuario!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 14
 );
 
  void loginErrortoast() =>
  Fluttertoast.showToast(
    msg: "Correo o contraseña incorrectos",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

   void notaErrortoast() =>
  Fluttertoast.showToast(
    msg: "Cuentanos un poco mas de tu actividad!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

    void notadiaErrortoast() =>
  Fluttertoast.showToast(
    msg: "No te olvides seleccionar tu dia!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

     void taskcreadotoast() =>
  Fluttertoast.showToast(
    msg: "Actividad registrada!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

  void bienvenidatoast() =>
  Fluttertoast.showToast(
    msg: "Bienvenido a Awake!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

   void actividadborrartoast() =>
  Fluttertoast.showToast(
    msg: "Actividad borrada con exito!",
        
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

     void notecreadotoast() =>
  Fluttertoast.showToast(
    msg: "Nota Registrada!",
        
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

      void noteerrortoast() =>
  Fluttertoast.showToast(
    msg: "Describamos nuestra nota primero!",
        
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );

       void borrarnotatoast() =>
  Fluttertoast.showToast(
    msg: "Nota borrada con exito!",
        
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black87,
    textColor: Colors.yellow[700],
    fontSize: 17
 );