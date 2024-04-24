import 'package:flutter/material.dart';

class Patologia {
  final int id;
  final String name;

  Patologia({
    required this.id,
    required this.name,
  });
}

final List<Patologia> PATOLOGIA = [
  Patologia(
    id: 0,
    name: 'Artritis',
  ),
  Patologia(
    id: 1,
    name: 'Artritis/Osteoartritis',
  ),
  Patologia(
    id: 2,
    name: 'Cardiopatías',

  ),
  Patologia(
    id: 3,
    name: 'Demencia o Alzheimer',

  ),
  Patologia(
    id: 4,
    name: 'Depresión ',
  ),
  Patologia(
    id: 5,
    name: 'Diabetes Mellitus',
  ),
  Patologia(
    id: 6,
    name: 'Hipertensión arterial',
  ),
  Patologia(
    id: 7,
    name: 'Osteoporosis',

  ),
  Patologia(
    id: 8,
    name: 'Parkinson',

  ),

];