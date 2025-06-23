import 'package:flutter/material.dart';

import 'crud/crud.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment - 3',
      home: Crud(),
    );
  }
}