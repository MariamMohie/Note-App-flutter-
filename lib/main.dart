import 'package:dairy_app/screens/Welcome%20Screen/Welcome%20Screen.dart';
import 'package:dairy_app/screens/home/home%20screen.dart';
import 'package:flutter/material.dart';

void main() {
  // should be added to create data base
  WidgetsFlutterBinding.ensureInitialized();
  //--------------------
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Remember',
      debugShowCheckedModeBanner: false,//available offline
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}



