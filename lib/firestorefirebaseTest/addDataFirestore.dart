import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addDataFirestore extends StatefulWidget {
  const addDataFirestore({super.key});

  @override
  State<addDataFirestore> createState() => _addDataFirestoreState();
}

class _addDataFirestoreState extends State<addDataFirestore> {
  var addDataCon = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Firestore Add page"),
        backgroundColor: Theme
            .of(context)
            .primaryColorLight,),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: addDataCon,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add your description",
              ),
            ),

            SizedBox(
              height: 10,
            ),

            ElevatedButton(child: Text("Add"),
              onPressed: () {
              final id = DateTime.now().millisecondsSinceEpoch.toString();
              firestore.doc(id).set({
                "title" : addDataCon.text.toString(),
                "id" : id
              })
              .then((value) {
                showMsgFire("Added");
              })
              .onError((error, stackTrace) {
                showMsgFire(error.toString());
              });

              addDataCon.text = "";
            },
            )
          ],
        ),
      ),
    );
  }
  showMsgFire(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

