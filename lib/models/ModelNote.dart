import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelNote {
  String? nota;
  String? color;
  DateTime? creadoEl;
  

  ModelNote({this.nota, this.color,  this.creadoEl,});

  // receiving data from server
  factory ModelNote.fromMap(map) {
    return ModelNote(
      nota: map['nota'],
      color: map['color'],
      creadoEl: (map['creadoEl'] as Timestamp).toDate(),
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'nota': nota,
      'color': color,
      'creadoEl':creadoEl,
    };
  }
}