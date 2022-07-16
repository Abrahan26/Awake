import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelTasks {
  String? actividad;
  String? importancia;
  DateTime? dia;
  

  ModelTasks({this.actividad, this.importancia,  this.dia,});

  // receiving data from server
  factory ModelTasks.fromMap(map) {
    return ModelTasks(
      actividad: map['actividad'],
      importancia: map['importancia'],
      dia: (map['dia'] as Timestamp).toDate(),
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'actividad': actividad,
      'importancia': importancia,
      'dia':dia,
    };
  }
}