import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de1/firestorefirebaseTest/addDataFirestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class firestore_list extends StatefulWidget {
  const firestore_list({super.key});

  @override
  State<firestore_list> createState() => _firestore_listState();
}

class _firestore_listState extends State<firestore_list> {

  TextEditingController searchcon = TextEditingController();
  TextEditingController editcon = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("users").snapshots();
  CollectionReference cr = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Firestore List Page"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchcon,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "search"
                ),
                onChanged: (String value){
                  setState(() {

                  });
                },
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Some Error Occur");
                }
                else if(snapshot.hasData){
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(snapshot.data!.docs[index]["id"].toString()),
                        title: Text(snapshot.data!.docs[index]["title"].toString()),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(leading: Icon(Icons.edit),title: Text("Update")),
                              value: 1,
                              onTap: (){
                                  showMyFirestoreDialog(snapshot.data!.docs[index]["title"].toString(), snapshot.data!.docs[index]["id"].toString());
                               },
                            ),

                            PopupMenuItem(
                                child: ListTile(leading: Icon(Icons.delete),title: Text("delete")),
                              value: 2,
                              onTap: (){
                                  cr.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                              },
                            ),
                          ],
                          icon: Icon(Icons.more_vert),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                }
                else{
                  return Container(child: Text("No data Found"),);
                }

                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => addDataFirestore(),));
      },child: Icon(Icons.add)),
    );
  }
  Future<void> showMyFirestoreDialog(String title,String id) async{
    editcon.text = title;
    return showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              controller: editcon,
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel")),
              TextButton(onPressed: (){
                cr.doc(id).update({
                  "title":editcon.text,
                  "id":id
                });
                Navigator.pop(context);
              }, child: Text("Update"),
              ),
            ],
          );
        }
    );
  }
}
