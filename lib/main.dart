// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import "package:firebase_database/firebase_database.dart";
import 'package:omni_notes/firebase_options.dart';
import 'notes_disp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

void updatefirebasedb(col) async {
  FirebaseDatabase inst = FirebaseDatabase.instance;
  DatabaseReference ref = inst.ref("notes");
  await ref.set({"data": col});
}

Future loadfromserver() async {
  FirebaseDatabase inst = FirebaseDatabase.instance;
  DatabaseReference ref = inst.ref("notes");
  // ref.onValue.listen((DatabaseEvent event) async{ return await event.snapshot.value["data"];   });
  final snapshot = await ref.get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    print("data could not be fetched!");
    return [];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omni notes',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Omni notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;
  late List<dynamic> col;

  @override
  void initState() {
    _counter = -1;
    col=[];
    Future myfuture = loadfromserver();
    myfuture.then((value) {
      setState(() {
      
      col = (value["data"] ?? [])  as List<dynamic>;
      Timer interval =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        updatefirebasedb(col);
      });
        
      });
    });

    super.initState();
  }

  newnote() {
    setState(() {
      _counter++;
      col.add('');
    });
  }

  updatenote(ind, val) {
    col[ind] = val;
  }

  @override
  Widget build(BuildContext context) {
    // print("inmain");
    print(col);
    Widget refreshwidg = NotesDisp(col: col, upd: updatenote);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your notes',
              ),
              refreshwidg
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newnote();
        },
        tooltip: 'New note',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
