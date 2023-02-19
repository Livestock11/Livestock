import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livestock/home_screen.dart';
import 'package:livestock/sign_up_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "Livestock",
    options: const FirebaseOptions(
      apiKey: "AIzaSyCT85nFnjSLdRDOmFn1uZwpC0d7VbjbnIo",
      appId: "1:716586941948:android:ff8f65d946cc2c36f58679",
      messagingSenderId: "716586941948",
      projectId: "livestock-d22f0",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livestock',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

      home: HomeScreen(),

    );
  }
}

