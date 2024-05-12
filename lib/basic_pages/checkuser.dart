import 'package:de1/basic_pages/login.dart';
import 'package:de1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class checkuser extends StatefulWidget{
  @override
  State<checkuser> createState() => _checkuserState();
}

class _checkuserState extends State<checkuser> {
  @override
  Widget build(BuildContext context) {
    return checkUserid();
  }
  checkUserid(){
    final user = FirebaseAuth.instance.currentUser;
    if(user==null){
      return loginPage();
    }else{
      return MyHomePage();
    }
  }

}