import 'package:de1/checkuser.dart';
import 'package:de1/cloudfire.dart';
import 'package:de1/login.dart';
import 'package:de1/notifipage.dart';
import 'package:de1/signup.dart';
import 'package:de1/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  logout() async{
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Main dart Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: (){
              logout();
            }, child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
