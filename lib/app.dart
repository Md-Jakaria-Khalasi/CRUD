import 'package:flutter/material.dart';

import 'CRUD/crud.dart';


class MyApp extends StatelessWidget{
  MyApp({super.key});

  @override
  Widget build(BuildContext contex){
    return MaterialApp(
      title: 'CRUD',
      home: Crud(),
    );
  }
}