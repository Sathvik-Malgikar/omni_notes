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
    refresh() {
      setState(() {});
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
            // print("before passing");
            // print(i);
            // print(val);
            widget.upd(i, val);
// print(val);
          }

          return Container(
              decoration: BoxDecoration(
                  color: Colors.yellow, borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  TextField(
                    maxLines: null,
                    // minLines: null,
                    // expands: true,
                    autofocus: true,
                    controller: contr,
                    textAlign: TextAlign.justify,
                    textAlignVertical: TextAlignVertical.top,
                    onChanged: handler,
                  ),
                  IconButton(
                      onPressed: () {
                        // print("printed");
                        widget.tcontrol.remove(contr);
                        print(widget.col.length);
                        widget.col.removeAt(i);
                        // print("LINE 75");
                        widget.colind.removeLast();
                        // print("LINE 77");
                        handler('');
                        // print("handler complete");
                        refresh();
                        // print("REFREESH");
                      },
                      icon: Icon(Icons.delete)),
                ],
              ));
        }).toList(),
      )),
    );
  }
}
