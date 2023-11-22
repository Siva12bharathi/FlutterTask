// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, no_logic_in_create_state, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, unused_local_variable, prefer_const_literals_to_create_immutables
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sample/notes_page.dart';


import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var box = await Hive.openBox('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        // ignore: deprecated_member_use
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {


  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }


  void navigationPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NotesPage(),
    ));
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTime();


    //removeNotification();

    /* onBackgroundMessage: (Map<String, dynamic> message){
      print('on backgorund: $message');
      return;
    },*//*
    );*/  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/note.png',height: 100,width: 100,),
              SizedBox(height: 30,),
              Text('Welcome to MyNotes',style: GoogleFonts.pacifico(fontSize: 35),),
            ],
          ),
          ),
        ),
      );

  }
}
