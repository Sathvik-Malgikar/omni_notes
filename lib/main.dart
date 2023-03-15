// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "toast.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:omni_notes/create_acc.dart';
import 'package:omni_notes/firebase_options.dart';
import 'notes_disp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

void updatefirebasedb(col) async {
  toast("All changes saved!");
  FirebaseDatabase inst = FirebaseDatabase.instance;
  DatabaseReference ref = inst.ref("notes");
  print("update called");
  print(MyApp.username);
  print(col);
  await ref.update({MyApp.username: col});
}

Future loadfromserver() async {
  FirebaseDatabase inst = FirebaseDatabase.instance;
  DatabaseReference ref = inst.ref("notes");
  // ref.onValue.listen((DatabaseEvent event) async{ return await event.snapshot.value["data"];   });
  final snapshot = await ref.get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    print(
        "data could not be fetched! empty dictionary returned possible new user");
    return {};
  }
}

Future check(val, pd) async {
  FirebaseDatabase inst = FirebaseDatabase.instance;
  DatabaseReference ref = inst.ref("auth");
  var snapshot = await ref.get();
  bool newuser = false;
  var d;
  if (snapshot.exists) {
    d = snapshot.value;
  } else {
    d = {};
  }
  if (d[val] == null) {
    newuser = true;
  }

  if (newuser) {
    d[val] = pd;
    ref.update({val: pd});
    return 1;
  } else {
    if (d[val] == pd)
      return 1;
    else
      return 2;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static String username = '';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omni notes',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Omni notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;
  late List<dynamic> col;
  dynamic timer;
  late bool timerset;

  @override
  void initState() {
    _counter = -1;
    col = [];
    timerset = false;
    super.initState();
  }

  login(val, pwd) {
    Future fut = check(val, pwd);
    fut.then(((resp) {
      if (resp == 1) {
        toast("Welcome back, $val !");
        setState(() {
          MyApp.username = val;
        });
        Future myfuture = loadfromserver();
        myfuture.then((value) {
          setState(() {
            col = (value[MyApp.username] ?? []) as List<dynamic>;
          });
        });
      } else if (resp == 2) {
        toast("incorrect password");
      } else {
        toast("error connecting to database!");
      }
    }));
  }

  newnote() {
    setState(() {
      _counter++;
      col.add('');
    });
  }

  updatenote(ind, val) {
    col[ind] = val;
    if (timerset) timer.cancel();
    timer = Timer(Duration(seconds: 2), () {
      updatefirebasedb(col);
      
      timerset = false;
    });
    timerset = true;
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
      body: MyApp.username != ''
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Your notes',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextButton.icon(
                              onPressed: () {
                                updatefirebasedb(col);
                              },
                              icon: Icon(Icons.save),
                              label: Text("save")),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextButton(
                            child: Text("Change username"),
                            onPressed: () {
                              setState(() {
                                _counter = -1;
                                col = [];
                                MyApp.username = '';
                                if (timerset == true) {
                                  timerset = false;
                                  timer.cancel();
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    refreshwidg
                  ],
                ),
              ),
            )
          : CreateAcc(login: login),
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
