import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcomepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("welcome",style: TextStyle(fontSize: 30),)),
    );
  }

}