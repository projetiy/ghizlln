import 'package:flutter/material.dart';
import 'package:get/get.dart'; // <-- ajoute ceci
import 'package:studium/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // <-- remplace MaterialApp par GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Studium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // <-- tu peux garder ton splash ici
    );
  }
}
