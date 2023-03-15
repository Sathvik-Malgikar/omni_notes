// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "toast.dart";

class CreateAcc extends StatelessWidget {
  CreateAcc({required this.login, super.key});

  var login;

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

  submit() {
    if (username == '' || password == '') {
      toast("enter valid details.");
      return;
    }
    login(username, password);
    username = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(child:Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Enter username and password."),
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
              onPressed: submit,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              child: Text("LOGIN"))
        ],
      ),
    ) ) ;
  }
}
