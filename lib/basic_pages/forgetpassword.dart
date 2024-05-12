import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class forgetPassword extends StatelessWidget{
  TextEditingController _emailcheck = TextEditingController();

  forgetpass(String email) async{
    if(email==null){
      print("Enter email address..........");
    }else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _emailcheck,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                forgetpass(_emailcheck.text.toString());
              },
              child: Text('Reset password'),
            ),
          ],
        ),
      ),
    );
  }

}