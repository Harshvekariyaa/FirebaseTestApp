import 'package:de1/forgetpassword.dart';
import 'package:de1/main.dart';
import 'package:de1/signup.dart';
import 'package:de1/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget{
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController _emailtxt1 = TextEditingController();
  TextEditingController _passtxt1 = TextEditingController();

  logIn(String email,String password) async{
    if(email=="" && password == ""){
      print("Enter details......................");
    }else{
      UserCredential? uc;
      try {
        uc = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: "title"),)));
      }
      on FirebaseAuthException catch(ex){
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _emailtxt1,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _passtxt1,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                logIn(_emailtxt1.text.toString(), _passtxt1.text.toString());
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => forgetPassword(),));
            }, child: Text("Forget password")),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => signup(),));
                }, child: Text(" Sign up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}