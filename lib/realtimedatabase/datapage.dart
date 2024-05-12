import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'descPage.dart';

class datapage extends StatefulWidget {
  const datapage({super.key});

  @override
  State<datapage> createState() => _datapageState();
}

class _datapageState extends State<datapage> {

  TextEditingController searchcon = TextEditingController();
  TextEditingController editcon = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('test1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("data Page"),
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
              child: FirebaseAnimatedList(
                query: databaseRef,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child("title").value.toString();

                  if(searchcon.text.isEmpty){
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString(),style: TextStyle(fontSize: 20),),
                      subtitle: Text(snapshot.child("id").value.toString()),
                      trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(leading: Icon(Icons.mode_edit),title: Text("Update"),),
                          value: 1,
                          onTap: (){
                            showMyDialog(title,snapshot.child("id").value.toString());
                          },
                        ),

                        PopupMenuItem(
                          child: ListTile(leading: Icon(Icons.delete),title: Text("Delete"),),
                          value: 1,
                          onTap: (){
                            databaseRef.child(snapshot.child("id").value.toString()).remove();
                          },
                        ),
                      ]
                      ),
                    );
                  }else if(title.toLowerCase().contains(searchcon.text.toLowerCase().toString())){
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString(),style: TextStyle(fontSize: 20),),
                      subtitle: Text(snapshot.child("id").value.toString()),);
                  }else{
                    return Container();
                  }
                },
              ),
            ),

            // Expanded(
            //     child: StreamBuilder(
            //       stream: databaseRef.onValue,
            //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //         if(!snapshot.hasData){
            //           return CircularProgressIndicator();
            //         }else {
            //           Map<dynamic, dynamic> map = snapshot.data!.snapshot
            //               .value as dynamic;
            //           List<dynamic> ls = [];
            //           ls.clear();
            //           ls = map.values.toList();
            //           return ListView.builder(
            //             itemBuilder: (context, index) {
            //               return ListTile(subtitle: Text(
            //                   ls[index]["id"].toString()), title: Text(
            //                 ls[index]["title"].toString(),
            //                 style: TextStyle(fontSize: 25),));
            //             },
            //             itemCount: snapshot.data!.snapshot.children.length,
            //           );
            //         }
            //        },
            //     )
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => descPage(),));
      },child: Icon(Icons.add)),
    );
  }

  Future<void> showMyDialog(String title,String id) async{
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
              Navigator.pop(context);
              databaseRef.child(id).update({
                "title" : editcon.text.toString(),
                "id" : id
              })
              .then((value){ return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated")));})
              .onError((error, stackTrace){
                return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));});

            }, child: Text("Update")),
          ],);
      }
    );
  }
}
