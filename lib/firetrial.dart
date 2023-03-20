import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart' ;
import 'package:omni_notes/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' ;
// import "dart:ui";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // if (kIsWeb || !Platform.isWindows)
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Firestore.initialize("omni-notes-34205");
  // // runApp(MyApp());
  putdataindb();
  print("hwlloworld");
}

void putdataindb() async {
 DocumentSnapshot snap = await FirebaseFirestore.instance.collection("trial").doc("newdoc").get();
//  Document doc = await Firestore.instance.collection("trial").document("newdoc").get();
 print(snap["fieldono"]);

// DocumentSnapshot snap =await FirebaseFirestore.instance.collection("trial").doc("newdoc").get();
// print ( snap.data() );
}


