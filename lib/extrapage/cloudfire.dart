import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cloudfire extends StatelessWidget {
  const cloudfire({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text("${index+1}"),),
                  title: Text("${snapshot.data!.docs[index]["sid"]}"),
                  subtitle: Text("${snapshot.data!.docs[index]["name"]}"),
                );
              },itemCount: snapshot.data!.docs.length);
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.toString()),);
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }


}
