
import 'package:de1/basic_pages/login.dart';
import 'package:de1/extrapage/notifipage.dart';
import 'package:de1/firestorefirebaseTest/firestore_list.dart';
import 'package:de1/uploadInFire/imageUploadScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:de1/realtimedatabase/datapage.dart';

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
      home: ImageUploadScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  logout() async{
    FirebaseAuth.instance.signOut();
    await Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => loginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main dart"),
      ),
    );
  }
}
