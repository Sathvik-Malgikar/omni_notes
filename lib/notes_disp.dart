// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

class NotesDisp extends StatefulWidget {
  NotesDisp({required this.col, required this.upd, super.key});

  var upd;
  List<dynamic> col;
  List<int> colind = [];
  List<TextEditingController> tcontrol = [];

  @override
  State<NotesDisp> createState() => _NotesDispState();
}

class _NotesDispState extends State<NotesDisp> {
  @override
  void dispose() {
    for (var contr in widget.tcontrol) {
      contr.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.col.length; i++) {
      widget.colind.add(i);
    }

    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.colind.map((i) {
          TextEditingController contr = TextEditingController();
          contr.text = widget.col[i];
          widget.tcontrol.add(contr);

          handler(val) {
            widget.upd(i, val);
// print(val);
          }

          return Container(
              decoration: BoxDecoration(
                  color: Colors.yellow, borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: contr,
                textAlign: TextAlign.justify,
                textAlignVertical: TextAlignVertical.top,
                onChanged: handler,
              ));
        }).toList(),
      )),
    );
  }
}
