// ignore_for_file: must_be_immutable



import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "toast.dart";
import "package:localstorage/localstorage.dart";

class CreateAcc extends StatelessWidget {
  CreateAcc({required this.login, super.key});

  var login;
  LocalStorage locstor = new LocalStorage("past");
  checklocstor(context){

  Future fut = locstor.ready;

  fut.then((value) {

    dynamic resp =  locstor.getItem("recent");
    if(resp!=null){
      username=resp["username"];
      password=resp["password"];
      submit(context);
    }

  });

  }
 
  String username = '';
  String password = '';
  TextEditingController contr = TextEditingController();
  TextEditingController contr2 = TextEditingController();
  storetext(val) {
    username = val;
  }

  storetext2(val) {
    password = val;
  }

  submit(context) {
    if (username == '' || password == '') {
      toast("enter valid details.",context);
      return;
    }
    login(username, password);

    locstor.setItem("recent", {"username" : username , "password" : password});

    password = '';
    contr2.text = '';
    username = '';
    contr.text = '';
  }

  @override
  Widget build(BuildContext context) {
    checklocstor(context);
    return Center(
        child: Container(
      child: RawKeyboardListener(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Enter Username and Password."),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                controller: contr,
                onChanged: storetext,
              ),
              color: Colors.yellow,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                obscureText: true,
                controller: contr2,
                onChanged: storetext2,
              ),
              color: Colors.yellow,
            ),
            TextButton(
                onPressed: () {
                  submit(context);
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                child: Text("LOGIN"))
          ],
        ),
      
      focusNode: FocusNode(),
      onKey: (event) {
      if(event.isKeyPressed(LogicalKeyboardKey.enter))
      submit(context);
      },
      ),
    ));
  }
}
