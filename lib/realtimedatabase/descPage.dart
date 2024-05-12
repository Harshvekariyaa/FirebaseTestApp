import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class descPage extends StatefulWidget {
  const descPage({super.key});

  @override
  State<descPage> createState() => _descPageState();
}

class _descPageState extends State<descPage> {
  TextEditingController txtdesc = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('test1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Your description!!"),backgroundColor: Theme.of(context).primaryColorLight,),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: txtdesc,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add your description",
              ),
            ),

            SizedBox(
              height: 10,
            ),

            ElevatedButton(child: Text("Add"), onPressed: (){
              String id =  DateTime.now().millisecond.toString();
              databaseRef.child(id).set({
                "id" : id,
                "title" : txtdesc.text.toString()
              }).then((value) { showMsg("Added.."); txtdesc.text = ""; })
                  .onError((error, stackTrace) => showMsg(error.toString()));
            },)
          ],
        ),
      ),
    );

  }

  showMsg(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
