import 'package:de1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget{
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController _emailtxt = TextEditingController();
  TextEditingController _passtxt = TextEditingController();

  signUp(String email,String pass) async {
    if(email=="" && pass==""){
        print("Enter Required feilds");
    }
    else{
      UserCredential? uc;
      try {
        uc = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: pass).then((value){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
        });
      }
      on FirebaseAuthException catch(ex){
        return AlertDialog(
          title: Text(ex.code.toString()),
        );
      }
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _emailtxt,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _passtxt,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          SizedBox(height: 19.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                signUp(_emailtxt.text.toString(), _passtxt.text.toString());
              },
              child: Center(child: Text('Sign up')),
            ),
          ),
        ],
      ),
    );
  }
}


