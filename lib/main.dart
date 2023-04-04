// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import "package:firedart/firedart.dart" as desk;
import 'package:flutter/material.dart';
import "toast.dart";
import "package:flutter/foundation.dart" show kIsWeb;
import "dart:io" show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omni_notes/create_acc.dart';
import 'package:omni_notes/firebase_options.dart';
import 'notes_disp.dart';
import "package:localstorage/localstorage.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || !Platform.isWindows)
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
        else desk.Firestore.initialize("omni-notes-34205");
  runApp(MyApp());
}

// class SUser {
//   String id;
//   String password;
//   String username;
//   SUser({this.id = '', required this.password, required this.username});

//   Map<String, String> toJson() =>
//       {"id": id, "password": password, "username": username};
// }

void updatefirebasedb(col,context) async {
  toast("All changes saved!",context);
  print("update called");
  print(MyApp.username);
  // print(col);
  if (kIsWeb || !Platform.isWindows) {
    // FirebaseDatabase inst = FirebaseDatabase.instance;
    // DatabaseReference ref = inst.ref("notes");
    // await ref.update({MyApp.username: col});

     await FirebaseFirestore.instance.collection("notes").doc("sticky").update({MyApp.username : col});
  } else {
    await desk.Firestore.instance.collection("notes").document("sticky").update({MyApp.username : col});
  }
}

Future loadfromserver() async {
  // ref.onValue.listen((DatabaseEvent event) async{ return await event.snapshot.value["data"];   });
  if (kIsWeb || !Platform.isWindows) {
    // FirebaseDatabase inst = FirebaseDatabase.instance;
    // DatabaseReference ref = inst.ref("notes");
    // final snapshot = await ref.get();
    // if (snapshot.exists) {
    //   return snapshot.value;
    // } else {
    //   print(
    //       "data could not be fetched! empty dictionary returned possible new user");
    //   return {};
    // }
 DocumentSnapshot snap =  await FirebaseFirestore.instance.collection("notes").doc("sticky").get();
    return await snap[MyApp.username];
  } else {
 
    desk.Document doc = await desk.Firestore.instance.collection("notes").document("sticky").get();
    return await doc[MyApp.username];
  }
}

Future check(val, pd) async {
  // FirebaseDatabase inst = FirebaseDatabase.instance;
  // DatabaseReference ref = inst.ref("auth");
  // var snapshot = await ref.get();
  // bool newuser = false;
  // var d;
  // if (snapshot.exists) {
  //   d = snapshot.value;
  // } else {
  //   d = {};
  // }
  // if (d[val] == null) {
  //   newuser = true;
  // }

  // if (newuser) {
  //   d[val] = pd;
  //   ref.update({val: pd});
  //   return 1;
  // } else {
  //   if (d[val] == pd)
  //     return 1;
  //   else
  //     return 2;
  // }
  print(kIsWeb);

  if (!kIsWeb) print(Platform.isWindows);
  dynamic sus,dref;
  if (kIsWeb || !Platform.isWindows) {
    print("HERE 101 non windows");
    
   
    DocumentReference docref = await FirebaseFirestore.instance.collection("auth").doc("users");
    dref=docref;
    DocumentSnapshot snap = await docref.get();
    
    sus = await snap.data()?? {};
    print("HHHERE" ); print(sus);
    sus= sus[val];
  }else{
//windows
print("windows 125");
desk.DocumentReference docref = await desk.Firestore.instance.collection("auth").document("users");
    dref=docref;
desk.Document doc = await docref.get();
sus=doc[val];
  }
    print("HERE LINE 105 ");
    bool newuser = false;
    print(sus);
    if (sus == null) newuser = true;

    if (newuser) {
      print("rgw");
      if (kIsWeb || !Platform.isWindows)
      await dref.update({val as Object: pd as Object?} ) ;
      else
      await dref.update({val  as String: pd } ) ;
      print("rgw");
      return 1;
    } else {
      if (sus != null && sus == pd)
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode nd = FocusScope.of(context);
        if (!nd.hasPrimaryFocus) {
          nd.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Omni notes',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: MyHomePage(title: 'Omni notes'),
      ),
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
        toast("Welcome back, $val !",context);
        setState(() {
          MyApp.username = val;
        });
        Future myfuture = loadfromserver();
        myfuture.then((value) {
          setState(() {
            col.clear();
            col.insertAll(col.length,  value ?? []);
          });
        });
      } else if (resp == 2) {
        toast("incorrect password",context);
      } else {
        toast("error connecting to database!",context);
        print(kIsWeb);
        if (!kIsWeb) print(Platform.isWindows);
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
  // print(col);
    if(val==''){

setState(() {
  // print("LINE 228");
      // col.removeAt(ind);

});
      
    }else
    col[ind] = val;
    if (timerset) timer.cancel();
    timer = Timer(Duration(seconds: 2), () {
      updatefirebasedb(col,context);

      timerset = false;
    });
    timerset = true;
  }

  @override
  Widget build(BuildContext context) {
    // print("inmain");
    // print(col);
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
                                updatefirebasedb(col,context);
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
                                LocalStorage stor =  new LocalStorage("past");
                                stor.clear();
                                _counter = -1;
                                col.clear();
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
      floatingActionButton: MyApp.username != ''
          ? FloatingActionButton(
              onPressed: () {
                newnote();
              },
              tooltip: 'New note',
              child: const Icon(Icons.add),
            )
          : Container(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
