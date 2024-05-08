import 'dart:js_interop';

import 'package:de1/checkuser.dart';
import 'package:de1/cloudfire.dart';
import 'package:de1/descPage.dart';
import 'package:de1/login.dart';
import 'package:de1/notifipage.dart';
import 'package:de1/signup.dart';
import 'package:de1/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyClK6EbZOxd21uhI3evrY3NlhIVwjYYA78", appId: "1:581949363669:web:80c663e3525ce23053195c", messagingSenderId: "581949363669", projectId: "demo01-dfb63"));
  }
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyAQ7oYhaHdeX-CobP8yiEYhUnNho8UuDMM", appId: "1:581949363669:android:1bf4d42bbd0547c053195c", messagingSenderId: "581949363669", projectId:"demo01-dfb63" ,storageBucket: "demo01-dfb63.appspot.com"),
  );

  // await notifipage.intialize();
  // await notifipage.intialize();
  await notifipage();
  // print(await FirebaseMessaging.instance.getToken());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:checkuser()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController searcCon = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('test1');

  logout() async{
    FirebaseAuth.instance.signOut();
    await Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => loginPage()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Main dart Page"),
        actions: [
          IconButton(onPressed: (){
            logout();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searcCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search"
                ),
                onChanged: (value){
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

                  if(searcCon.text.isEmpty) {
                    return ListTile(title: Text(snapshot
                        .child("title")
                        .value
                        .toString(), style: TextStyle(fontSize: 25),),
                      subtitle: Text(snapshot
                          .child("id")
                          .value
                          .toString()),);
                  }
                  else if(title.toLowerCase().contains(searcCon.text.toLowerCase().toString())){
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString(),style: TextStyle(fontSize: 25),),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
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
}
